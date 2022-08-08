//// Automatically Generated From BuildableNodes.swift.gyb.
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

/// A CodeBlockItem is any Syntax node that appears on its own line insidea CodeBlock.
public struct CodeBlockItem: SyntaxBuildable, ExpressibleAsCodeBlockItem {
  let garbageBeforeItem: GarbageNodes?
  let item: SyntaxBuildable
  let garbageBetweenItemAndSemicolon: GarbageNodes?
  let semicolon: TokenSyntax?
  let garbageBetweenSemicolonAndErrorTokens: GarbageNodes?
  let errorTokens: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CodeBlockItem` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeItem: 
  ///   - item: The underlying node inside the code block.
  ///   - garbageBetweenItemAndSemicolon: 
  ///   - semicolon: If present, the trailing semicolon at the end of the item.
  ///   - garbageBetweenSemicolonAndErrorTokens: 
  ///   - errorTokens: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeItem: ExpressibleAsGarbageNodes? = nil,
    item: ExpressibleAsSyntaxBuildable,
    garbageBetweenItemAndSemicolon: ExpressibleAsGarbageNodes? = nil,
    semicolon: TokenSyntax? = nil,
    garbageBetweenSemicolonAndErrorTokens: ExpressibleAsGarbageNodes? = nil,
    errorTokens: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeItem = garbageBeforeItem?.createGarbageNodes()
    self.item = item.createSyntaxBuildable()
    self.garbageBetweenItemAndSemicolon = garbageBetweenItemAndSemicolon?.createGarbageNodes()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
    self.garbageBetweenSemicolonAndErrorTokens = garbageBetweenSemicolonAndErrorTokens?.createGarbageNodes()
    self.errorTokens = errorTokens?.createSyntaxBuildable()
  }


  /// Builds a `CodeBlockItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CodeBlockItemSyntax`.
  func buildCodeBlockItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CodeBlockItemSyntax {
    let result = SyntaxFactory.makeCodeBlockItem(
      garbageBeforeItem?.buildGarbageNodes(format: format, leadingTrivia: nil),
      item: item.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenItemAndSemicolon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      semicolon: semicolon,
      garbageBetweenSemicolonAndErrorTokens?.buildGarbageNodes(format: format, leadingTrivia: nil),
      errorTokens: errorTokens?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCodeBlockItem(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCodeBlockItem`.
  public func createCodeBlockItem() -> CodeBlockItem {
    return self
  }

  /// `CodeBlockItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CodeBlock: SyntaxBuildable, ExpressibleAsCodeBlock {
  let garbageBeforeLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndStatements: GarbageNodes?
  let statements: CodeBlockItemList
  let garbageBetweenStatementsAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CodeBlock` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndStatements: 
  ///   - statements: 
  ///   - garbageBetweenStatementsAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndStatements: ExpressibleAsGarbageNodes? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    garbageBetweenStatementsAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftBrace = garbageBeforeLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndStatements = garbageBetweenLeftBraceAndStatements?.createGarbageNodes()
    self.statements = statements.createCodeBlockItemList()
    self.garbageBetweenStatementsAndRightBrace = garbageBetweenStatementsAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndStatements: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenStatementsAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftBrace: garbageBeforeLeftBrace,
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndStatements: garbageBetweenLeftBraceAndStatements,
      statements: statementsBuilder(),
      garbageBetweenStatementsAndRightBrace: garbageBetweenStatementsAndRightBrace,
      rightBrace: rightBrace
    )
  }

  /// Builds a `CodeBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CodeBlockSyntax`.
  func buildCodeBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CodeBlockSyntax {
    let result = SyntaxFactory.makeCodeBlock(
      garbageBeforeLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndStatements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil),
      garbageBetweenStatementsAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCodeBlock(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCodeBlock`.
  public func createCodeBlock() -> CodeBlock {
    return self
  }

  /// `CodeBlock` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct InOutExpr: ExprBuildable, ExpressibleAsInOutExpr {
  let garbageBeforeAmpersand: GarbageNodes?
  let ampersand: TokenSyntax
  let garbageBetweenAmpersandAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InOutExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAmpersand: 
  ///   - ampersand: 
  ///   - garbageBetweenAmpersandAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAmpersand: ExpressibleAsGarbageNodes? = nil,
    ampersand: TokenSyntax = TokenSyntax.`prefixAmpersand`,
    garbageBetweenAmpersandAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAmpersand = garbageBeforeAmpersand?.createGarbageNodes()
    self.ampersand = ampersand
    assert(ampersand.text == "&")
    self.garbageBetweenAmpersandAndExpression = garbageBetweenAmpersandAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `InOutExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InOutExprSyntax`.
  func buildInOutExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InOutExprSyntax {
    let result = SyntaxFactory.makeInOutExpr(
      garbageBeforeAmpersand?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ampersand: ampersand,
      garbageBetweenAmpersandAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildInOutExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsInOutExpr`.
  public func createInOutExpr() -> InOutExpr {
    return self
  }

  /// `InOutExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `InOutExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundColumnExpr: ExprBuildable, ExpressibleAsPoundColumnExpr {
  let garbageBeforePoundColumn: GarbageNodes?
  let poundColumn: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundColumnExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundColumn: 
  ///   - poundColumn: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundColumn: ExpressibleAsGarbageNodes? = nil,
    poundColumn: TokenSyntax = TokenSyntax.`poundColumn`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundColumn = garbageBeforePoundColumn?.createGarbageNodes()
    self.poundColumn = poundColumn
    assert(poundColumn.text == "#column")
  }


  /// Builds a `PoundColumnExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundColumnExprSyntax`.
  func buildPoundColumnExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundColumnExprSyntax {
    let result = SyntaxFactory.makePoundColumnExpr(
      garbageBeforePoundColumn?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundColumn: poundColumn
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundColumnExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundColumnExpr`.
  public func createPoundColumnExpr() -> PoundColumnExpr {
    return self
  }

  /// `PoundColumnExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundColumnExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TryExpr: ExprBuildable, ExpressibleAsTryExpr {
  let garbageBeforeTryKeyword: GarbageNodes?
  let tryKeyword: TokenSyntax
  let garbageBetweenTryKeywordAndQuestionOrExclamationMark: GarbageNodes?
  let questionOrExclamationMark: TokenSyntax?
  let garbageBetweenQuestionOrExclamationMarkAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TryExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeTryKeyword: 
  ///   - tryKeyword: 
  ///   - garbageBetweenTryKeywordAndQuestionOrExclamationMark: 
  ///   - questionOrExclamationMark: 
  ///   - garbageBetweenQuestionOrExclamationMarkAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeTryKeyword: ExpressibleAsGarbageNodes? = nil,
    tryKeyword: TokenSyntax = TokenSyntax.`try`,
    garbageBetweenTryKeywordAndQuestionOrExclamationMark: ExpressibleAsGarbageNodes? = nil,
    questionOrExclamationMark: TokenSyntax? = nil,
    garbageBetweenQuestionOrExclamationMarkAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeTryKeyword = garbageBeforeTryKeyword?.createGarbageNodes()
    self.tryKeyword = tryKeyword
    assert(tryKeyword.text == "try")
    self.garbageBetweenTryKeywordAndQuestionOrExclamationMark = garbageBetweenTryKeywordAndQuestionOrExclamationMark?.createGarbageNodes()
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.garbageBetweenQuestionOrExclamationMarkAndExpression = garbageBetweenQuestionOrExclamationMarkAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `TryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TryExprSyntax`.
  func buildTryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TryExprSyntax {
    let result = SyntaxFactory.makeTryExpr(
      garbageBeforeTryKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      tryKeyword: tryKeyword,
      garbageBetweenTryKeywordAndQuestionOrExclamationMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionOrExclamationMark: questionOrExclamationMark,
      garbageBetweenQuestionOrExclamationMarkAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTryExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsTryExpr`.
  public func createTryExpr() -> TryExpr {
    return self
  }

  /// `TryExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `TryExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AwaitExpr: ExprBuildable, ExpressibleAsAwaitExpr {
  let garbageBeforeAwaitKeyword: GarbageNodes?
  let awaitKeyword: TokenSyntax
  let garbageBetweenAwaitKeywordAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AwaitExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAwaitKeyword: 
  ///   - awaitKeyword: 
  ///   - garbageBetweenAwaitKeywordAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAwaitKeyword: ExpressibleAsGarbageNodes? = nil,
    awaitKeyword: TokenSyntax,
    garbageBetweenAwaitKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAwaitKeyword = garbageBeforeAwaitKeyword?.createGarbageNodes()
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword.text == "await")
    self.garbageBetweenAwaitKeywordAndExpression = garbageBetweenAwaitKeywordAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAwaitKeyword: ExpressibleAsGarbageNodes? = nil,
    awaitKeyword: String,
    garbageBetweenAwaitKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAwaitKeyword: garbageBeforeAwaitKeyword,
      awaitKeyword: TokenSyntax.contextualKeyword(awaitKeyword),
      garbageBetweenAwaitKeywordAndExpression: garbageBetweenAwaitKeywordAndExpression,
      expression: expression
    )
  }

  /// Builds a `AwaitExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AwaitExprSyntax`.
  func buildAwaitExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AwaitExprSyntax {
    let result = SyntaxFactory.makeAwaitExpr(
      garbageBeforeAwaitKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      awaitKeyword: awaitKeyword,
      garbageBetweenAwaitKeywordAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAwaitExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsAwaitExpr`.
  public func createAwaitExpr() -> AwaitExpr {
    return self
  }

  /// `AwaitExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `AwaitExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MoveExpr: ExprBuildable, ExpressibleAsMoveExpr {
  let garbageBeforeMoveKeyword: GarbageNodes?
  let moveKeyword: TokenSyntax
  let garbageBetweenMoveKeywordAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MoveExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeMoveKeyword: 
  ///   - moveKeyword: 
  ///   - garbageBetweenMoveKeywordAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeMoveKeyword: ExpressibleAsGarbageNodes? = nil,
    moveKeyword: TokenSyntax,
    garbageBetweenMoveKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeMoveKeyword = garbageBeforeMoveKeyword?.createGarbageNodes()
    self.moveKeyword = moveKeyword
    assert(moveKeyword.text == "_move")
    self.garbageBetweenMoveKeywordAndExpression = garbageBetweenMoveKeywordAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeMoveKeyword: ExpressibleAsGarbageNodes? = nil,
    moveKeyword: String,
    garbageBetweenMoveKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeMoveKeyword: garbageBeforeMoveKeyword,
      moveKeyword: TokenSyntax.contextualKeyword(moveKeyword),
      garbageBetweenMoveKeywordAndExpression: garbageBetweenMoveKeywordAndExpression,
      expression: expression
    )
  }

  /// Builds a `MoveExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MoveExprSyntax`.
  func buildMoveExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MoveExprSyntax {
    let result = SyntaxFactory.makeMoveExpr(
      garbageBeforeMoveKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      moveKeyword: moveKeyword,
      garbageBetweenMoveKeywordAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildMoveExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsMoveExpr`.
  public func createMoveExpr() -> MoveExpr {
    return self
  }

  /// `MoveExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `MoveExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DeclNameArgument: SyntaxBuildable, ExpressibleAsDeclNameArgument {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndColon: GarbageNodes?
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclNameArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndColon: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndColon = garbageBetweenNameAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
  }


  /// Builds a `DeclNameArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameArgumentSyntax`.
  func buildDeclNameArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameArgumentSyntax {
    let result = SyntaxFactory.makeDeclNameArgument(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclNameArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDeclNameArgument`.
  public func createDeclNameArgument() -> DeclNameArgument {
    return self
  }

  /// `DeclNameArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DeclNameArguments: SyntaxBuildable, ExpressibleAsDeclNameArguments {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndArguments: GarbageNodes?
  let arguments: DeclNameArgumentList
  let garbageBetweenArgumentsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclNameArguments` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArguments: 
  ///   - arguments: 
  ///   - garbageBetweenArgumentsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsDeclNameArgumentList,
    garbageBetweenArgumentsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndArguments = garbageBetweenLeftParenAndArguments?.createGarbageNodes()
    self.arguments = arguments.createDeclNameArgumentList()
    self.garbageBetweenArgumentsAndRightParen = garbageBetweenArgumentsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `DeclNameArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameArgumentsSyntax`.
  func buildDeclNameArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameArgumentsSyntax {
    let result = SyntaxFactory.makeDeclNameArguments(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments.buildDeclNameArgumentList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclNameArguments(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDeclNameArguments`.
  public func createDeclNameArguments() -> DeclNameArguments {
    return self
  }

  /// `DeclNameArguments` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct IdentifierExpr: ExprBuildable, ExpressibleAsIdentifierExpr {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndDeclNameArguments: GarbageNodes?
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IdentifierExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndDeclNameArguments: 
  ///   - declNameArguments: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndDeclNameArguments: ExpressibleAsGarbageNodes? = nil,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndDeclNameArguments = garbageBetweenIdentifierAndDeclNameArguments?.createGarbageNodes()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `IdentifierExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IdentifierExprSyntax`.
  func buildIdentifierExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IdentifierExprSyntax {
    let result = SyntaxFactory.makeIdentifierExpr(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndDeclNameArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIdentifierExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsIdentifierExpr`.
  public func createIdentifierExpr() -> IdentifierExpr {
    return self
  }

  /// `IdentifierExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `IdentifierExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SuperRefExpr: ExprBuildable, ExpressibleAsSuperRefExpr {
  let garbageBeforeSuperKeyword: GarbageNodes?
  let superKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SuperRefExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSuperKeyword: 
  ///   - superKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSuperKeyword: ExpressibleAsGarbageNodes? = nil,
    superKeyword: TokenSyntax = TokenSyntax.`super`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSuperKeyword = garbageBeforeSuperKeyword?.createGarbageNodes()
    self.superKeyword = superKeyword
    assert(superKeyword.text == "super")
  }


  /// Builds a `SuperRefExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SuperRefExprSyntax`.
  func buildSuperRefExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SuperRefExprSyntax {
    let result = SyntaxFactory.makeSuperRefExpr(
      garbageBeforeSuperKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      superKeyword: superKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSuperRefExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsSuperRefExpr`.
  public func createSuperRefExpr() -> SuperRefExpr {
    return self
  }

  /// `SuperRefExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `SuperRefExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct NilLiteralExpr: ExprBuildable, ExpressibleAsNilLiteralExpr {
  let garbageBeforeNilKeyword: GarbageNodes?
  let nilKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `NilLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeNilKeyword: 
  ///   - nilKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeNilKeyword: ExpressibleAsGarbageNodes? = nil,
    nilKeyword: TokenSyntax = TokenSyntax.`nil`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeNilKeyword = garbageBeforeNilKeyword?.createGarbageNodes()
    self.nilKeyword = nilKeyword
    assert(nilKeyword.text == "nil")
  }


  /// Builds a `NilLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `NilLiteralExprSyntax`.
  func buildNilLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> NilLiteralExprSyntax {
    let result = SyntaxFactory.makeNilLiteralExpr(
      garbageBeforeNilKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      nilKeyword: nilKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildNilLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsNilLiteralExpr`.
  public func createNilLiteralExpr() -> NilLiteralExpr {
    return self
  }

  /// `NilLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `NilLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DiscardAssignmentExpr: ExprBuildable, ExpressibleAsDiscardAssignmentExpr {
  let garbageBeforeWildcard: GarbageNodes?
  let wildcard: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DiscardAssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWildcard: 
  ///   - wildcard: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWildcard: ExpressibleAsGarbageNodes? = nil,
    wildcard: TokenSyntax = TokenSyntax.`wildcard`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWildcard = garbageBeforeWildcard?.createGarbageNodes()
    self.wildcard = wildcard
    assert(wildcard.text == "_")
  }


  /// Builds a `DiscardAssignmentExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DiscardAssignmentExprSyntax`.
  func buildDiscardAssignmentExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DiscardAssignmentExprSyntax {
    let result = SyntaxFactory.makeDiscardAssignmentExpr(
      garbageBeforeWildcard?.buildGarbageNodes(format: format, leadingTrivia: nil),
      wildcard: wildcard
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildDiscardAssignmentExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsDiscardAssignmentExpr`.
  public func createDiscardAssignmentExpr() -> DiscardAssignmentExpr {
    return self
  }

  /// `DiscardAssignmentExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `DiscardAssignmentExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AssignmentExpr: ExprBuildable, ExpressibleAsAssignmentExpr {
  let garbageBeforeAssignToken: GarbageNodes?
  let assignToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAssignToken: 
  ///   - assignToken: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAssignToken: ExpressibleAsGarbageNodes? = nil,
    assignToken: TokenSyntax = TokenSyntax.`equal`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAssignToken = garbageBeforeAssignToken?.createGarbageNodes()
    self.assignToken = assignToken
    assert(assignToken.text == "=")
  }


  /// Builds a `AssignmentExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AssignmentExprSyntax`.
  func buildAssignmentExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AssignmentExprSyntax {
    let result = SyntaxFactory.makeAssignmentExpr(
      garbageBeforeAssignToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      assignToken: assignToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAssignmentExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsAssignmentExpr`.
  public func createAssignmentExpr() -> AssignmentExpr {
    return self
  }

  /// `AssignmentExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `AssignmentExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SequenceExpr: ExprBuildable, ExpressibleAsSequenceExpr {
  let garbageBeforeElements: GarbageNodes?
  let elements: ExprList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SequenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeElements: 
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsExprList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeElements = garbageBeforeElements?.createGarbageNodes()
    self.elements = elements.createExprList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeElements: ExpressibleAsGarbageNodes? = nil,
    @ExprListBuilder elementsBuilder: () -> ExpressibleAsExprList = { ExprList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeElements: garbageBeforeElements,
      elements: elementsBuilder()
    )
  }

  /// Builds a `SequenceExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SequenceExprSyntax`.
  func buildSequenceExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SequenceExprSyntax {
    let result = SyntaxFactory.makeSequenceExpr(
      garbageBeforeElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildExprList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSequenceExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsSequenceExpr`.
  public func createSequenceExpr() -> SequenceExpr {
    return self
  }

  /// `SequenceExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `SequenceExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundLineExpr: ExprBuildable, ExpressibleAsPoundLineExpr {
  let garbageBeforePoundLine: GarbageNodes?
  let poundLine: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundLineExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundLine: 
  ///   - poundLine: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundLine: ExpressibleAsGarbageNodes? = nil,
    poundLine: TokenSyntax = TokenSyntax.`poundLine`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundLine = garbageBeforePoundLine?.createGarbageNodes()
    self.poundLine = poundLine
    assert(poundLine.text == "#line")
  }


  /// Builds a `PoundLineExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundLineExprSyntax`.
  func buildPoundLineExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundLineExprSyntax {
    let result = SyntaxFactory.makePoundLineExpr(
      garbageBeforePoundLine?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundLine: poundLine
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundLineExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundLineExpr`.
  public func createPoundLineExpr() -> PoundLineExpr {
    return self
  }

  /// `PoundLineExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundLineExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundFileExpr: ExprBuildable, ExpressibleAsPoundFileExpr {
  let garbageBeforePoundFile: GarbageNodes?
  let poundFile: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFileExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundFile: 
  ///   - poundFile: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundFile: ExpressibleAsGarbageNodes? = nil,
    poundFile: TokenSyntax = TokenSyntax.`poundFile`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundFile = garbageBeforePoundFile?.createGarbageNodes()
    self.poundFile = poundFile
    assert(poundFile.text == "#file")
  }


  /// Builds a `PoundFileExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFileExprSyntax`.
  func buildPoundFileExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFileExprSyntax {
    let result = SyntaxFactory.makePoundFileExpr(
      garbageBeforePoundFile?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundFile: poundFile
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFileExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundFileExpr`.
  public func createPoundFileExpr() -> PoundFileExpr {
    return self
  }

  /// `PoundFileExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundFileExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundFileIDExpr: ExprBuildable, ExpressibleAsPoundFileIDExpr {
  let garbageBeforePoundFileID: GarbageNodes?
  let poundFileID: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFileIDExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundFileID: 
  ///   - poundFileID: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundFileID: ExpressibleAsGarbageNodes? = nil,
    poundFileID: TokenSyntax = TokenSyntax.`poundFileID`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundFileID = garbageBeforePoundFileID?.createGarbageNodes()
    self.poundFileID = poundFileID
    assert(poundFileID.text == "#fileID")
  }


  /// Builds a `PoundFileIDExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFileIDExprSyntax`.
  func buildPoundFileIDExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFileIDExprSyntax {
    let result = SyntaxFactory.makePoundFileIDExpr(
      garbageBeforePoundFileID?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundFileID: poundFileID
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFileIDExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundFileIDExpr`.
  public func createPoundFileIDExpr() -> PoundFileIDExpr {
    return self
  }

  /// `PoundFileIDExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundFileIDExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundFilePathExpr: ExprBuildable, ExpressibleAsPoundFilePathExpr {
  let garbageBeforePoundFilePath: GarbageNodes?
  let poundFilePath: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFilePathExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundFilePath: 
  ///   - poundFilePath: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundFilePath: ExpressibleAsGarbageNodes? = nil,
    poundFilePath: TokenSyntax = TokenSyntax.`poundFilePath`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundFilePath = garbageBeforePoundFilePath?.createGarbageNodes()
    self.poundFilePath = poundFilePath
    assert(poundFilePath.text == "#filePath")
  }


  /// Builds a `PoundFilePathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFilePathExprSyntax`.
  func buildPoundFilePathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFilePathExprSyntax {
    let result = SyntaxFactory.makePoundFilePathExpr(
      garbageBeforePoundFilePath?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundFilePath: poundFilePath
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFilePathExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundFilePathExpr`.
  public func createPoundFilePathExpr() -> PoundFilePathExpr {
    return self
  }

  /// `PoundFilePathExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundFilePathExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundFunctionExpr: ExprBuildable, ExpressibleAsPoundFunctionExpr {
  let garbageBeforePoundFunction: GarbageNodes?
  let poundFunction: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFunctionExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundFunction: 
  ///   - poundFunction: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundFunction: ExpressibleAsGarbageNodes? = nil,
    poundFunction: TokenSyntax = TokenSyntax.`poundFunction`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundFunction = garbageBeforePoundFunction?.createGarbageNodes()
    self.poundFunction = poundFunction
    assert(poundFunction.text == "#function")
  }


  /// Builds a `PoundFunctionExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFunctionExprSyntax`.
  func buildPoundFunctionExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFunctionExprSyntax {
    let result = SyntaxFactory.makePoundFunctionExpr(
      garbageBeforePoundFunction?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundFunction: poundFunction
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFunctionExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundFunctionExpr`.
  public func createPoundFunctionExpr() -> PoundFunctionExpr {
    return self
  }

  /// `PoundFunctionExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundFunctionExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundDsohandleExpr: ExprBuildable, ExpressibleAsPoundDsohandleExpr {
  let garbageBeforePoundDsohandle: GarbageNodes?
  let poundDsohandle: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundDsohandleExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundDsohandle: 
  ///   - poundDsohandle: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundDsohandle: ExpressibleAsGarbageNodes? = nil,
    poundDsohandle: TokenSyntax = TokenSyntax.`poundDsohandle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundDsohandle = garbageBeforePoundDsohandle?.createGarbageNodes()
    self.poundDsohandle = poundDsohandle
    assert(poundDsohandle.text == "#dsohandle")
  }


  /// Builds a `PoundDsohandleExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundDsohandleExprSyntax`.
  func buildPoundDsohandleExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundDsohandleExprSyntax {
    let result = SyntaxFactory.makePoundDsohandleExpr(
      garbageBeforePoundDsohandle?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundDsohandle: poundDsohandle
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundDsohandleExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundDsohandleExpr`.
  public func createPoundDsohandleExpr() -> PoundDsohandleExpr {
    return self
  }

  /// `PoundDsohandleExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PoundDsohandleExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SymbolicReferenceExpr: ExprBuildable, ExpressibleAsSymbolicReferenceExpr {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericArgumentClause: GarbageNodes?
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SymbolicReferenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericArgumentClause: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericArgumentClause: ExpressibleAsGarbageNodes? = nil,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericArgumentClause = garbageBetweenIdentifierAndGenericArgumentClause?.createGarbageNodes()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericArgumentClause: ExpressibleAsGarbageNodes? = nil,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeIdentifier: garbageBeforeIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericArgumentClause: garbageBetweenIdentifierAndGenericArgumentClause,
      genericArgumentClause: genericArgumentClause
    )
  }

  /// Builds a `SymbolicReferenceExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SymbolicReferenceExprSyntax`.
  func buildSymbolicReferenceExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SymbolicReferenceExprSyntax {
    let result = SyntaxFactory.makeSymbolicReferenceExpr(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericArgumentClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSymbolicReferenceExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsSymbolicReferenceExpr`.
  public func createSymbolicReferenceExpr() -> SymbolicReferenceExpr {
    return self
  }

  /// `SymbolicReferenceExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `SymbolicReferenceExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PrefixOperatorExpr: ExprBuildable, ExpressibleAsPrefixOperatorExpr {
  let garbageBeforeOperatorToken: GarbageNodes?
  let operatorToken: TokenSyntax?
  let garbageBetweenOperatorTokenAndPostfixExpression: GarbageNodes?
  let postfixExpression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrefixOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeOperatorToken: 
  ///   - operatorToken: 
  ///   - garbageBetweenOperatorTokenAndPostfixExpression: 
  ///   - postfixExpression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOperatorToken: ExpressibleAsGarbageNodes? = nil,
    operatorToken: TokenSyntax? = nil,
    garbageBetweenOperatorTokenAndPostfixExpression: ExpressibleAsGarbageNodes? = nil,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeOperatorToken = garbageBeforeOperatorToken?.createGarbageNodes()
    self.operatorToken = operatorToken
    self.garbageBetweenOperatorTokenAndPostfixExpression = garbageBetweenOperatorTokenAndPostfixExpression?.createGarbageNodes()
    self.postfixExpression = postfixExpression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOperatorToken: ExpressibleAsGarbageNodes? = nil,
    operatorToken: String?,
    garbageBetweenOperatorTokenAndPostfixExpression: ExpressibleAsGarbageNodes? = nil,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeOperatorToken: garbageBeforeOperatorToken,
      operatorToken: operatorToken.map(TokenSyntax.prefixOperator),
      garbageBetweenOperatorTokenAndPostfixExpression: garbageBetweenOperatorTokenAndPostfixExpression,
      postfixExpression: postfixExpression
    )
  }

  /// Builds a `PrefixOperatorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrefixOperatorExprSyntax`.
  func buildPrefixOperatorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrefixOperatorExprSyntax {
    let result = SyntaxFactory.makePrefixOperatorExpr(
      garbageBeforeOperatorToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorToken: operatorToken,
      garbageBetweenOperatorTokenAndPostfixExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      postfixExpression: postfixExpression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPrefixOperatorExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPrefixOperatorExpr`.
  public func createPrefixOperatorExpr() -> PrefixOperatorExpr {
    return self
  }

  /// `PrefixOperatorExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PrefixOperatorExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct BinaryOperatorExpr: ExprBuildable, ExpressibleAsBinaryOperatorExpr {
  let garbageBeforeOperatorToken: GarbageNodes?
  let operatorToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BinaryOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeOperatorToken: 
  ///   - operatorToken: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOperatorToken: ExpressibleAsGarbageNodes? = nil,
    operatorToken: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeOperatorToken = garbageBeforeOperatorToken?.createGarbageNodes()
    self.operatorToken = operatorToken
  }


  /// Builds a `BinaryOperatorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BinaryOperatorExprSyntax`.
  func buildBinaryOperatorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BinaryOperatorExprSyntax {
    let result = SyntaxFactory.makeBinaryOperatorExpr(
      garbageBeforeOperatorToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorToken: operatorToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildBinaryOperatorExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsBinaryOperatorExpr`.
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    return self
  }

  /// `BinaryOperatorExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `BinaryOperatorExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ArrowExpr: ExprBuildable, ExpressibleAsArrowExpr {
  let garbageBeforeAsyncKeyword: GarbageNodes?
  let asyncKeyword: TokenSyntax?
  let garbageBetweenAsyncKeywordAndThrowsToken: GarbageNodes?
  let throwsToken: TokenSyntax?
  let garbageBetweenThrowsTokenAndArrowToken: GarbageNodes?
  let arrowToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrowExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAsyncKeyword: 
  ///   - asyncKeyword: 
  ///   - garbageBetweenAsyncKeywordAndThrowsToken: 
  ///   - throwsToken: 
  ///   - garbageBetweenThrowsTokenAndArrowToken: 
  ///   - arrowToken: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: TokenSyntax? = nil,
    garbageBetweenAsyncKeywordAndThrowsToken: ExpressibleAsGarbageNodes? = nil,
    throwsToken: TokenSyntax? = nil,
    garbageBetweenThrowsTokenAndArrowToken: ExpressibleAsGarbageNodes? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAsyncKeyword = garbageBeforeAsyncKeyword?.createGarbageNodes()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.garbageBetweenAsyncKeywordAndThrowsToken = garbageBetweenAsyncKeywordAndThrowsToken?.createGarbageNodes()
    self.throwsToken = throwsToken
    assert(throwsToken == nil || throwsToken!.text == "throws")
    self.garbageBetweenThrowsTokenAndArrowToken = garbageBetweenThrowsTokenAndArrowToken?.createGarbageNodes()
    self.arrowToken = arrowToken
    assert(arrowToken.text == "->")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: String?,
    garbageBetweenAsyncKeywordAndThrowsToken: ExpressibleAsGarbageNodes? = nil,
    throwsToken: TokenSyntax? = nil,
    garbageBetweenThrowsTokenAndArrowToken: ExpressibleAsGarbageNodes? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAsyncKeyword: garbageBeforeAsyncKeyword,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      garbageBetweenAsyncKeywordAndThrowsToken: garbageBetweenAsyncKeywordAndThrowsToken,
      throwsToken: throwsToken,
      garbageBetweenThrowsTokenAndArrowToken: garbageBetweenThrowsTokenAndArrowToken,
      arrowToken: arrowToken
    )
  }

  /// Builds a `ArrowExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrowExprSyntax`.
  func buildArrowExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrowExprSyntax {
    let result = SyntaxFactory.makeArrowExpr(
      garbageBeforeAsyncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      garbageBetweenAsyncKeywordAndThrowsToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwsToken: throwsToken,
      garbageBetweenThrowsTokenAndArrowToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arrowToken: arrowToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildArrowExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsArrowExpr`.
  public func createArrowExpr() -> ArrowExpr {
    return self
  }

  /// `ArrowExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ArrowExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct InfixOperatorExpr: ExprBuildable, ExpressibleAsInfixOperatorExpr {
  let garbageBeforeLeftOperand: GarbageNodes?
  let leftOperand: ExprBuildable
  let garbageBetweenLeftOperandAndOperatorOperand: GarbageNodes?
  let operatorOperand: ExprBuildable
  let garbageBetweenOperatorOperandAndRightOperand: GarbageNodes?
  let rightOperand: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InfixOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftOperand: 
  ///   - leftOperand: 
  ///   - garbageBetweenLeftOperandAndOperatorOperand: 
  ///   - operatorOperand: 
  ///   - garbageBetweenOperatorOperandAndRightOperand: 
  ///   - rightOperand: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftOperand: ExpressibleAsGarbageNodes? = nil,
    leftOperand: ExpressibleAsExprBuildable,
    garbageBetweenLeftOperandAndOperatorOperand: ExpressibleAsGarbageNodes? = nil,
    operatorOperand: ExpressibleAsExprBuildable,
    garbageBetweenOperatorOperandAndRightOperand: ExpressibleAsGarbageNodes? = nil,
    rightOperand: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftOperand = garbageBeforeLeftOperand?.createGarbageNodes()
    self.leftOperand = leftOperand.createExprBuildable()
    self.garbageBetweenLeftOperandAndOperatorOperand = garbageBetweenLeftOperandAndOperatorOperand?.createGarbageNodes()
    self.operatorOperand = operatorOperand.createExprBuildable()
    self.garbageBetweenOperatorOperandAndRightOperand = garbageBetweenOperatorOperandAndRightOperand?.createGarbageNodes()
    self.rightOperand = rightOperand.createExprBuildable()
  }


  /// Builds a `InfixOperatorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InfixOperatorExprSyntax`.
  func buildInfixOperatorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InfixOperatorExprSyntax {
    let result = SyntaxFactory.makeInfixOperatorExpr(
      garbageBeforeLeftOperand?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftOperand: leftOperand.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenLeftOperandAndOperatorOperand?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorOperand: operatorOperand.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenOperatorOperandAndRightOperand?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightOperand: rightOperand.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildInfixOperatorExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsInfixOperatorExpr`.
  public func createInfixOperatorExpr() -> InfixOperatorExpr {
    return self
  }

  /// `InfixOperatorExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `InfixOperatorExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct FloatLiteralExpr: ExprBuildable, ExpressibleAsFloatLiteralExpr {
  let garbageBeforeFloatingDigits: GarbageNodes?
  let floatingDigits: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FloatLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeFloatingDigits: 
  ///   - floatingDigits: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeFloatingDigits: ExpressibleAsGarbageNodes? = nil,
    floatingDigits: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeFloatingDigits = garbageBeforeFloatingDigits?.createGarbageNodes()
    self.floatingDigits = floatingDigits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeFloatingDigits: ExpressibleAsGarbageNodes? = nil,
    floatingDigits: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeFloatingDigits: garbageBeforeFloatingDigits,
      floatingDigits: TokenSyntax.floatingLiteral(floatingDigits)
    )
  }

  /// Builds a `FloatLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FloatLiteralExprSyntax`.
  func buildFloatLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FloatLiteralExprSyntax {
    let result = SyntaxFactory.makeFloatLiteralExpr(
      garbageBeforeFloatingDigits?.buildGarbageNodes(format: format, leadingTrivia: nil),
      floatingDigits: floatingDigits
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildFloatLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsFloatLiteralExpr`.
  public func createFloatLiteralExpr() -> FloatLiteralExpr {
    return self
  }

  /// `FloatLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `FloatLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TupleExpr: ExprBuildable, ExpressibleAsTupleExpr {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndElementList: GarbageNodes?
  let elementList: TupleExprElementList
  let garbageBetweenElementListAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndElementList: 
  ///   - elementList: 
  ///   - garbageBetweenElementListAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElementList: ExpressibleAsGarbageNodes? = nil,
    elementList: ExpressibleAsTupleExprElementList,
    garbageBetweenElementListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndElementList = garbageBetweenLeftParenAndElementList?.createGarbageNodes()
    self.elementList = elementList.createTupleExprElementList()
    self.garbageBetweenElementListAndRightParen = garbageBetweenElementListAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElementList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenElementListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndElementList: garbageBetweenLeftParenAndElementList,
      elementList: elementListBuilder(),
      garbageBetweenElementListAndRightParen: garbageBetweenElementListAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `TupleExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleExprSyntax`.
  func buildTupleExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleExprSyntax {
    let result = SyntaxFactory.makeTupleExpr(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndElementList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elementList: elementList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenElementListAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTupleExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsTupleExpr`.
  public func createTupleExpr() -> TupleExpr {
    return self
  }

  /// `TupleExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `TupleExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ArrayExpr: ExprBuildable, ExpressibleAsArrayExpr {
  let garbageBeforeLeftSquare: GarbageNodes?
  let leftSquare: TokenSyntax
  let garbageBetweenLeftSquareAndElements: GarbageNodes?
  let elements: ArrayElementList
  let garbageBetweenElementsAndRightSquare: GarbageNodes?
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftSquare: 
  ///   - leftSquare: 
  ///   - garbageBetweenLeftSquareAndElements: 
  ///   - elements: 
  ///   - garbageBetweenElementsAndRightSquare: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquare: ExpressibleAsGarbageNodes? = nil,
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareAndElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsArrayElementList,
    garbageBetweenElementsAndRightSquare: ExpressibleAsGarbageNodes? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftSquare = garbageBeforeLeftSquare?.createGarbageNodes()
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.garbageBetweenLeftSquareAndElements = garbageBetweenLeftSquareAndElements?.createGarbageNodes()
    self.elements = elements.createArrayElementList()
    self.garbageBetweenElementsAndRightSquare = garbageBetweenElementsAndRightSquare?.createGarbageNodes()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquare: ExpressibleAsGarbageNodes? = nil,
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareAndElements: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenElementsAndRightSquare: ExpressibleAsGarbageNodes? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ExpressibleAsArrayElementList = { ArrayElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftSquare: garbageBeforeLeftSquare,
      leftSquare: leftSquare,
      garbageBetweenLeftSquareAndElements: garbageBetweenLeftSquareAndElements,
      elements: elementsBuilder(),
      garbageBetweenElementsAndRightSquare: garbageBetweenElementsAndRightSquare,
      rightSquare: rightSquare
    )
  }

  /// Builds a `ArrayExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayExprSyntax`.
  func buildArrayExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayExprSyntax {
    let result = SyntaxFactory.makeArrayExpr(
      garbageBeforeLeftSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftSquare: leftSquare,
      garbageBetweenLeftSquareAndElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildArrayElementList(format: format, leadingTrivia: nil),
      garbageBetweenElementsAndRightSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildArrayExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsArrayExpr`.
  public func createArrayExpr() -> ArrayExpr {
    return self
  }

  /// `ArrayExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ArrayExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DictionaryExpr: ExprBuildable, ExpressibleAsDictionaryExpr {
  let garbageBeforeLeftSquare: GarbageNodes?
  let leftSquare: TokenSyntax
  let garbageBetweenLeftSquareAndContent: GarbageNodes?
  let content: SyntaxBuildable
  let garbageBetweenContentAndRightSquare: GarbageNodes?
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftSquare: 
  ///   - leftSquare: 
  ///   - garbageBetweenLeftSquareAndContent: 
  ///   - content: 
  ///   - garbageBetweenContentAndRightSquare: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquare: ExpressibleAsGarbageNodes? = nil,
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareAndContent: ExpressibleAsGarbageNodes? = nil,
    content: ExpressibleAsSyntaxBuildable,
    garbageBetweenContentAndRightSquare: ExpressibleAsGarbageNodes? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftSquare = garbageBeforeLeftSquare?.createGarbageNodes()
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.garbageBetweenLeftSquareAndContent = garbageBetweenLeftSquareAndContent?.createGarbageNodes()
    self.content = content.createSyntaxBuildable()
    self.garbageBetweenContentAndRightSquare = garbageBetweenContentAndRightSquare?.createGarbageNodes()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }


  /// Builds a `DictionaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryExprSyntax`.
  func buildDictionaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryExprSyntax {
    let result = SyntaxFactory.makeDictionaryExpr(
      garbageBeforeLeftSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftSquare: leftSquare,
      garbageBetweenLeftSquareAndContent?.buildGarbageNodes(format: format, leadingTrivia: nil),
      content: content.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenContentAndRightSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildDictionaryExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsDictionaryExpr`.
  public func createDictionaryExpr() -> DictionaryExpr {
    return self
  }

  /// `DictionaryExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `DictionaryExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TupleExprElement: SyntaxBuildable, ExpressibleAsTupleExprElement, HasTrailingComma {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax?
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax?
  let garbageBetweenColonAndExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleExprElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: 
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax? = nil,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.garbageBetweenColonAndExpression = garbageBetweenColonAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndTrailingComma = garbageBetweenExpressionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `TupleExprElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleExprElementSyntax`.
  func buildTupleExprElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleExprElementSyntax {
    let result = SyntaxFactory.makeTupleExprElement(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTupleExprElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTupleExprElement`.
  public func createTupleExprElement() -> TupleExprElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeLabel: garbageBeforeLabel,
        label: label,
        garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
        colon: colon,
        garbageBetweenColonAndExpression: garbageBetweenColonAndExpression,
        expression: expression,
        garbageBetweenExpressionAndTrailingComma: garbageBetweenExpressionAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `TupleExprElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ArrayElement: SyntaxBuildable, ExpressibleAsArrayElement, HasTrailingComma {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndTrailingComma = garbageBetweenExpressionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ArrayElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayElementSyntax`.
  func buildArrayElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayElementSyntax {
    let result = SyntaxFactory.makeArrayElement(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildArrayElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsArrayElement`.
  public func createArrayElement() -> ArrayElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeExpression: garbageBeforeExpression,
        expression: expression,
        garbageBetweenExpressionAndTrailingComma: garbageBetweenExpressionAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `ArrayElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DictionaryElement: SyntaxBuildable, ExpressibleAsDictionaryElement, HasTrailingComma {
  let garbageBeforeKeyExpression: GarbageNodes?
  let keyExpression: ExprBuildable
  let garbageBetweenKeyExpressionAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndValueExpression: GarbageNodes?
  let valueExpression: ExprBuildable
  let garbageBetweenValueExpressionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeKeyExpression: 
  ///   - keyExpression: 
  ///   - garbageBetweenKeyExpressionAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndValueExpression: 
  ///   - valueExpression: 
  ///   - garbageBetweenValueExpressionAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeKeyExpression: ExpressibleAsGarbageNodes? = nil,
    keyExpression: ExpressibleAsExprBuildable,
    garbageBetweenKeyExpressionAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValueExpression: ExpressibleAsGarbageNodes? = nil,
    valueExpression: ExpressibleAsExprBuildable,
    garbageBetweenValueExpressionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeKeyExpression = garbageBeforeKeyExpression?.createGarbageNodes()
    self.keyExpression = keyExpression.createExprBuildable()
    self.garbageBetweenKeyExpressionAndColon = garbageBetweenKeyExpressionAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndValueExpression = garbageBetweenColonAndValueExpression?.createGarbageNodes()
    self.valueExpression = valueExpression.createExprBuildable()
    self.garbageBetweenValueExpressionAndTrailingComma = garbageBetweenValueExpressionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `DictionaryElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryElementSyntax`.
  func buildDictionaryElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryElementSyntax {
    let result = SyntaxFactory.makeDictionaryElement(
      garbageBeforeKeyExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      keyExpression: keyExpression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenKeyExpressionAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndValueExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      valueExpression: valueExpression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenValueExpressionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDictionaryElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDictionaryElement`.
  public func createDictionaryElement() -> DictionaryElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeKeyExpression: garbageBeforeKeyExpression,
        keyExpression: keyExpression,
        garbageBetweenKeyExpressionAndColon: garbageBetweenKeyExpressionAndColon,
        colon: colon,
        garbageBetweenColonAndValueExpression: garbageBetweenColonAndValueExpression,
        valueExpression: valueExpression,
        garbageBetweenValueExpressionAndTrailingComma: garbageBetweenValueExpressionAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `DictionaryElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct IntegerLiteralExpr: ExprBuildable, ExpressibleAsIntegerLiteralExpr {
  let garbageBeforeDigits: GarbageNodes?
  let digits: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IntegerLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDigits: 
  ///   - digits: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDigits: ExpressibleAsGarbageNodes? = nil,
    digits: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDigits = garbageBeforeDigits?.createGarbageNodes()
    self.digits = digits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDigits: ExpressibleAsGarbageNodes? = nil,
    digits: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeDigits: garbageBeforeDigits,
      digits: TokenSyntax.integerLiteral(digits)
    )
  }

  /// Builds a `IntegerLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IntegerLiteralExprSyntax`.
  func buildIntegerLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IntegerLiteralExprSyntax {
    let result = SyntaxFactory.makeIntegerLiteralExpr(
      garbageBeforeDigits?.buildGarbageNodes(format: format, leadingTrivia: nil),
      digits: digits
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIntegerLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsIntegerLiteralExpr`.
  public func createIntegerLiteralExpr() -> IntegerLiteralExpr {
    return self
  }

  /// `IntegerLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `IntegerLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct BooleanLiteralExpr: ExprBuildable, ExpressibleAsBooleanLiteralExpr {
  let garbageBeforeBooleanLiteral: GarbageNodes?
  let booleanLiteral: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BooleanLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBooleanLiteral: 
  ///   - booleanLiteral: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBooleanLiteral: ExpressibleAsGarbageNodes? = nil,
    booleanLiteral: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBooleanLiteral = garbageBeforeBooleanLiteral?.createGarbageNodes()
    self.booleanLiteral = booleanLiteral
    assert(booleanLiteral.text == "true" || booleanLiteral.text == "false")
  }


  /// Builds a `BooleanLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BooleanLiteralExprSyntax`.
  func buildBooleanLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BooleanLiteralExprSyntax {
    let result = SyntaxFactory.makeBooleanLiteralExpr(
      garbageBeforeBooleanLiteral?.buildGarbageNodes(format: format, leadingTrivia: nil),
      booleanLiteral: booleanLiteral
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildBooleanLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsBooleanLiteralExpr`.
  public func createBooleanLiteralExpr() -> BooleanLiteralExpr {
    return self
  }

  /// `BooleanLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `BooleanLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TernaryExpr: ExprBuildable, ExpressibleAsTernaryExpr {
  let garbageBeforeConditionExpression: GarbageNodes?
  let conditionExpression: ExprBuildable
  let garbageBetweenConditionExpressionAndQuestionMark: GarbageNodes?
  let questionMark: TokenSyntax
  let garbageBetweenQuestionMarkAndFirstChoice: GarbageNodes?
  let firstChoice: ExprBuildable
  let garbageBetweenFirstChoiceAndColonMark: GarbageNodes?
  let colonMark: TokenSyntax
  let garbageBetweenColonMarkAndSecondChoice: GarbageNodes?
  let secondChoice: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TernaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeConditionExpression: 
  ///   - conditionExpression: 
  ///   - garbageBetweenConditionExpressionAndQuestionMark: 
  ///   - questionMark: 
  ///   - garbageBetweenQuestionMarkAndFirstChoice: 
  ///   - firstChoice: 
  ///   - garbageBetweenFirstChoiceAndColonMark: 
  ///   - colonMark: 
  ///   - garbageBetweenColonMarkAndSecondChoice: 
  ///   - secondChoice: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeConditionExpression: ExpressibleAsGarbageNodes? = nil,
    conditionExpression: ExpressibleAsExprBuildable,
    garbageBetweenConditionExpressionAndQuestionMark: ExpressibleAsGarbageNodes? = nil,
    questionMark: TokenSyntax = TokenSyntax.`infixQuestionMark`,
    garbageBetweenQuestionMarkAndFirstChoice: ExpressibleAsGarbageNodes? = nil,
    firstChoice: ExpressibleAsExprBuildable,
    garbageBetweenFirstChoiceAndColonMark: ExpressibleAsGarbageNodes? = nil,
    colonMark: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonMarkAndSecondChoice: ExpressibleAsGarbageNodes? = nil,
    secondChoice: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeConditionExpression = garbageBeforeConditionExpression?.createGarbageNodes()
    self.conditionExpression = conditionExpression.createExprBuildable()
    self.garbageBetweenConditionExpressionAndQuestionMark = garbageBetweenConditionExpressionAndQuestionMark?.createGarbageNodes()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
    self.garbageBetweenQuestionMarkAndFirstChoice = garbageBetweenQuestionMarkAndFirstChoice?.createGarbageNodes()
    self.firstChoice = firstChoice.createExprBuildable()
    self.garbageBetweenFirstChoiceAndColonMark = garbageBetweenFirstChoiceAndColonMark?.createGarbageNodes()
    self.colonMark = colonMark
    assert(colonMark.text == ":")
    self.garbageBetweenColonMarkAndSecondChoice = garbageBetweenColonMarkAndSecondChoice?.createGarbageNodes()
    self.secondChoice = secondChoice.createExprBuildable()
  }


  /// Builds a `TernaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TernaryExprSyntax`.
  func buildTernaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TernaryExprSyntax {
    let result = SyntaxFactory.makeTernaryExpr(
      garbageBeforeConditionExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      conditionExpression: conditionExpression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenConditionExpressionAndQuestionMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionMark: questionMark,
      garbageBetweenQuestionMarkAndFirstChoice?.buildGarbageNodes(format: format, leadingTrivia: nil),
      firstChoice: firstChoice.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenFirstChoiceAndColonMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colonMark: colonMark,
      garbageBetweenColonMarkAndSecondChoice?.buildGarbageNodes(format: format, leadingTrivia: nil),
      secondChoice: secondChoice.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTernaryExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsTernaryExpr`.
  public func createTernaryExpr() -> TernaryExpr {
    return self
  }

  /// `TernaryExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `TernaryExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MemberAccessExpr: ExprBuildable, ExpressibleAsMemberAccessExpr {
  let garbageBeforeBase: GarbageNodes?
  let base: ExprBuildable?
  let garbageBetweenBaseAndDot: GarbageNodes?
  let dot: TokenSyntax
  let garbageBetweenDotAndName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndDeclNameArguments: GarbageNodes?
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberAccessExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBase: 
  ///   - base: 
  ///   - garbageBetweenBaseAndDot: 
  ///   - dot: 
  ///   - garbageBetweenDotAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndDeclNameArguments: 
  ///   - declNameArguments: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBase: ExpressibleAsGarbageNodes? = nil,
    base: ExpressibleAsExprBuildable? = nil,
    garbageBetweenBaseAndDot: ExpressibleAsGarbageNodes? = nil,
    dot: TokenSyntax,
    garbageBetweenDotAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndDeclNameArguments: ExpressibleAsGarbageNodes? = nil,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBase = garbageBeforeBase?.createGarbageNodes()
    self.base = base?.createExprBuildable()
    self.garbageBetweenBaseAndDot = garbageBetweenBaseAndDot?.createGarbageNodes()
    self.dot = dot
    assert(dot.text == "." || dot.text == ".")
    self.garbageBetweenDotAndName = garbageBetweenDotAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndDeclNameArguments = garbageBetweenNameAndDeclNameArguments?.createGarbageNodes()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `MemberAccessExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberAccessExprSyntax`.
  func buildMemberAccessExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberAccessExprSyntax {
    let result = SyntaxFactory.makeMemberAccessExpr(
      garbageBeforeBase?.buildGarbageNodes(format: format, leadingTrivia: nil),
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenBaseAndDot?.buildGarbageNodes(format: format, leadingTrivia: nil),
      dot: dot,
      garbageBetweenDotAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndDeclNameArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildMemberAccessExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsMemberAccessExpr`.
  public func createMemberAccessExpr() -> MemberAccessExpr {
    return self
  }

  /// `MemberAccessExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `MemberAccessExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct IsExpr: ExprBuildable, ExpressibleAsIsExpr {
  let garbageBeforeIsTok: GarbageNodes?
  let isTok: TokenSyntax
  let garbageBetweenIsTokAndTypeName: GarbageNodes?
  let typeName: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IsExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIsTok: 
  ///   - isTok: 
  ///   - garbageBetweenIsTokAndTypeName: 
  ///   - typeName: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIsTok: ExpressibleAsGarbageNodes? = nil,
    isTok: TokenSyntax = TokenSyntax.`is`,
    garbageBetweenIsTokAndTypeName: ExpressibleAsGarbageNodes? = nil,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIsTok = garbageBeforeIsTok?.createGarbageNodes()
    self.isTok = isTok
    assert(isTok.text == "is")
    self.garbageBetweenIsTokAndTypeName = garbageBetweenIsTokAndTypeName?.createGarbageNodes()
    self.typeName = typeName.createTypeBuildable()
  }


  /// Builds a `IsExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IsExprSyntax`.
  func buildIsExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IsExprSyntax {
    let result = SyntaxFactory.makeIsExpr(
      garbageBeforeIsTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      isTok: isTok,
      garbageBetweenIsTokAndTypeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIsExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsIsExpr`.
  public func createIsExpr() -> IsExpr {
    return self
  }

  /// `IsExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `IsExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AsExpr: ExprBuildable, ExpressibleAsAsExpr {
  let garbageBeforeAsTok: GarbageNodes?
  let asTok: TokenSyntax
  let garbageBetweenAsTokAndQuestionOrExclamationMark: GarbageNodes?
  let questionOrExclamationMark: TokenSyntax?
  let garbageBetweenQuestionOrExclamationMarkAndTypeName: GarbageNodes?
  let typeName: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AsExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAsTok: 
  ///   - asTok: 
  ///   - garbageBetweenAsTokAndQuestionOrExclamationMark: 
  ///   - questionOrExclamationMark: 
  ///   - garbageBetweenQuestionOrExclamationMarkAndTypeName: 
  ///   - typeName: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAsTok: ExpressibleAsGarbageNodes? = nil,
    asTok: TokenSyntax = TokenSyntax.`as`,
    garbageBetweenAsTokAndQuestionOrExclamationMark: ExpressibleAsGarbageNodes? = nil,
    questionOrExclamationMark: TokenSyntax? = nil,
    garbageBetweenQuestionOrExclamationMarkAndTypeName: ExpressibleAsGarbageNodes? = nil,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAsTok = garbageBeforeAsTok?.createGarbageNodes()
    self.asTok = asTok
    assert(asTok.text == "as")
    self.garbageBetweenAsTokAndQuestionOrExclamationMark = garbageBetweenAsTokAndQuestionOrExclamationMark?.createGarbageNodes()
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.garbageBetweenQuestionOrExclamationMarkAndTypeName = garbageBetweenQuestionOrExclamationMarkAndTypeName?.createGarbageNodes()
    self.typeName = typeName.createTypeBuildable()
  }


  /// Builds a `AsExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AsExprSyntax`.
  func buildAsExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AsExprSyntax {
    let result = SyntaxFactory.makeAsExpr(
      garbageBeforeAsTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asTok: asTok,
      garbageBetweenAsTokAndQuestionOrExclamationMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionOrExclamationMark: questionOrExclamationMark,
      garbageBetweenQuestionOrExclamationMarkAndTypeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAsExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsAsExpr`.
  public func createAsExpr() -> AsExpr {
    return self
  }

  /// `AsExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `AsExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TypeExpr: ExprBuildable, ExpressibleAsTypeExpr {
  let garbageBeforeType: GarbageNodes?
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeType: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeType = garbageBeforeType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
  }


  /// Builds a `TypeExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeExprSyntax`.
  func buildTypeExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeExprSyntax {
    let result = SyntaxFactory.makeTypeExpr(
      garbageBeforeType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTypeExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsTypeExpr`.
  public func createTypeExpr() -> TypeExpr {
    return self
  }

  /// `TypeExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `TypeExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ClosureCaptureItem: SyntaxBuildable, ExpressibleAsClosureCaptureItem, HasTrailingComma {
  let garbageBeforeSpecifier: GarbageNodes?
  let specifier: TokenList?
  let garbageBetweenSpecifierAndName: GarbageNodes?
  let name: TokenSyntax?
  let garbageBetweenNameAndAssignToken: GarbageNodes?
  let assignToken: TokenSyntax?
  let garbageBetweenAssignTokenAndExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureCaptureItem` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSpecifier: 
  ///   - specifier: 
  ///   - garbageBetweenSpecifierAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndAssignToken: 
  ///   - assignToken: 
  ///   - garbageBetweenAssignTokenAndExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSpecifier: ExpressibleAsGarbageNodes? = nil,
    specifier: ExpressibleAsTokenList? = nil,
    garbageBetweenSpecifierAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax? = nil,
    garbageBetweenNameAndAssignToken: ExpressibleAsGarbageNodes? = nil,
    assignToken: TokenSyntax? = nil,
    garbageBetweenAssignTokenAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSpecifier = garbageBeforeSpecifier?.createGarbageNodes()
    self.specifier = specifier?.createTokenList()
    self.garbageBetweenSpecifierAndName = garbageBetweenSpecifierAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndAssignToken = garbageBetweenNameAndAssignToken?.createGarbageNodes()
    self.assignToken = assignToken
    assert(assignToken == nil || assignToken!.text == "=")
    self.garbageBetweenAssignTokenAndExpression = garbageBetweenAssignTokenAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndTrailingComma = garbageBetweenExpressionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSpecifier: ExpressibleAsGarbageNodes? = nil,
    specifier: ExpressibleAsTokenList? = nil,
    garbageBetweenSpecifierAndName: ExpressibleAsGarbageNodes? = nil,
    name: String?,
    garbageBetweenNameAndAssignToken: ExpressibleAsGarbageNodes? = nil,
    assignToken: TokenSyntax? = nil,
    garbageBetweenAssignTokenAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeSpecifier: garbageBeforeSpecifier,
      specifier: specifier,
      garbageBetweenSpecifierAndName: garbageBetweenSpecifierAndName,
      name: name.map(TokenSyntax.identifier),
      garbageBetweenNameAndAssignToken: garbageBetweenNameAndAssignToken,
      assignToken: assignToken,
      garbageBetweenAssignTokenAndExpression: garbageBetweenAssignTokenAndExpression,
      expression: expression,
      garbageBetweenExpressionAndTrailingComma: garbageBetweenExpressionAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `ClosureCaptureItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureCaptureItemSyntax`.
  func buildClosureCaptureItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureCaptureItemSyntax {
    let result = SyntaxFactory.makeClosureCaptureItem(
      garbageBeforeSpecifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      specifier: specifier?.buildTokenList(format: format, leadingTrivia: nil),
      garbageBetweenSpecifierAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndAssignToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      assignToken: assignToken,
      garbageBetweenAssignTokenAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureCaptureItem(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureCaptureItem`.
  public func createClosureCaptureItem() -> ClosureCaptureItem {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeSpecifier: garbageBeforeSpecifier,
        specifier: specifier,
        garbageBetweenSpecifierAndName: garbageBetweenSpecifierAndName,
        name: name,
        garbageBetweenNameAndAssignToken: garbageBetweenNameAndAssignToken,
        assignToken: assignToken,
        garbageBetweenAssignTokenAndExpression: garbageBetweenAssignTokenAndExpression,
        expression: expression,
        garbageBetweenExpressionAndTrailingComma: garbageBetweenExpressionAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `ClosureCaptureItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ClosureCaptureSignature: SyntaxBuildable, ExpressibleAsClosureCaptureSignature {
  let garbageBeforeLeftSquare: GarbageNodes?
  let leftSquare: TokenSyntax
  let garbageBetweenLeftSquareAndItems: GarbageNodes?
  let items: ClosureCaptureItemList?
  let garbageBetweenItemsAndRightSquare: GarbageNodes?
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureCaptureSignature` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftSquare: 
  ///   - leftSquare: 
  ///   - garbageBetweenLeftSquareAndItems: 
  ///   - items: 
  ///   - garbageBetweenItemsAndRightSquare: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquare: ExpressibleAsGarbageNodes? = nil,
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareAndItems: ExpressibleAsGarbageNodes? = nil,
    items: ExpressibleAsClosureCaptureItemList? = nil,
    garbageBetweenItemsAndRightSquare: ExpressibleAsGarbageNodes? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftSquare = garbageBeforeLeftSquare?.createGarbageNodes()
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.garbageBetweenLeftSquareAndItems = garbageBetweenLeftSquareAndItems?.createGarbageNodes()
    self.items = items?.createClosureCaptureItemList()
    self.garbageBetweenItemsAndRightSquare = garbageBetweenItemsAndRightSquare?.createGarbageNodes()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquare: ExpressibleAsGarbageNodes? = nil,
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareAndItems: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenItemsAndRightSquare: ExpressibleAsGarbageNodes? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ExpressibleAsClosureCaptureItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftSquare: garbageBeforeLeftSquare,
      leftSquare: leftSquare,
      garbageBetweenLeftSquareAndItems: garbageBetweenLeftSquareAndItems,
      items: itemsBuilder(),
      garbageBetweenItemsAndRightSquare: garbageBetweenItemsAndRightSquare,
      rightSquare: rightSquare
    )
  }

  /// Builds a `ClosureCaptureSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureCaptureSignatureSyntax`.
  func buildClosureCaptureSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureCaptureSignatureSyntax {
    let result = SyntaxFactory.makeClosureCaptureSignature(
      garbageBeforeLeftSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftSquare: leftSquare,
      garbageBetweenLeftSquareAndItems?.buildGarbageNodes(format: format, leadingTrivia: nil),
      items: items?.buildClosureCaptureItemList(format: format, leadingTrivia: nil),
      garbageBetweenItemsAndRightSquare?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureCaptureSignature(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureCaptureSignature`.
  public func createClosureCaptureSignature() -> ClosureCaptureSignature {
    return self
  }

  /// `ClosureCaptureSignature` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ClosureParam: SyntaxBuildable, ExpressibleAsClosureParam, HasTrailingComma {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureParam` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndTrailingComma = garbageBetweenNameAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ClosureParamSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureParamSyntax`.
  func buildClosureParam(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureParamSyntax {
    let result = SyntaxFactory.makeClosureParam(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureParam(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureParam`.
  public func createClosureParam() -> ClosureParam {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeName: garbageBeforeName,
        name: name,
        garbageBetweenNameAndTrailingComma: garbageBetweenNameAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `ClosureParam` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ClosureSignature: SyntaxBuildable, ExpressibleAsClosureSignature {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndCapture: GarbageNodes?
  let capture: ClosureCaptureSignature?
  let garbageBetweenCaptureAndInput: GarbageNodes?
  let input: SyntaxBuildable?
  let garbageBetweenInputAndAsyncKeyword: GarbageNodes?
  let asyncKeyword: TokenSyntax?
  let garbageBetweenAsyncKeywordAndThrowsTok: GarbageNodes?
  let throwsTok: TokenSyntax?
  let garbageBetweenThrowsTokAndOutput: GarbageNodes?
  let output: ReturnClause?
  let garbageBetweenOutputAndInTok: GarbageNodes?
  let inTok: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureSignature` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndCapture: 
  ///   - capture: 
  ///   - garbageBetweenCaptureAndInput: 
  ///   - input: 
  ///   - garbageBetweenInputAndAsyncKeyword: 
  ///   - asyncKeyword: 
  ///   - garbageBetweenAsyncKeywordAndThrowsTok: 
  ///   - throwsTok: 
  ///   - garbageBetweenThrowsTokAndOutput: 
  ///   - output: 
  ///   - garbageBetweenOutputAndInTok: 
  ///   - inTok: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndCapture: ExpressibleAsGarbageNodes? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    garbageBetweenCaptureAndInput: ExpressibleAsGarbageNodes? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    garbageBetweenInputAndAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: TokenSyntax? = nil,
    garbageBetweenAsyncKeywordAndThrowsTok: ExpressibleAsGarbageNodes? = nil,
    throwsTok: TokenSyntax? = nil,
    garbageBetweenThrowsTokAndOutput: ExpressibleAsGarbageNodes? = nil,
    output: ExpressibleAsReturnClause? = nil,
    garbageBetweenOutputAndInTok: ExpressibleAsGarbageNodes? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndCapture = garbageBetweenAttributesAndCapture?.createGarbageNodes()
    self.capture = capture?.createClosureCaptureSignature()
    self.garbageBetweenCaptureAndInput = garbageBetweenCaptureAndInput?.createGarbageNodes()
    self.input = input?.createSyntaxBuildable()
    self.garbageBetweenInputAndAsyncKeyword = garbageBetweenInputAndAsyncKeyword?.createGarbageNodes()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.garbageBetweenAsyncKeywordAndThrowsTok = garbageBetweenAsyncKeywordAndThrowsTok?.createGarbageNodes()
    self.throwsTok = throwsTok
    assert(throwsTok == nil || throwsTok!.text == "throws")
    self.garbageBetweenThrowsTokAndOutput = garbageBetweenThrowsTokAndOutput?.createGarbageNodes()
    self.output = output?.createReturnClause()
    self.garbageBetweenOutputAndInTok = garbageBetweenOutputAndInTok?.createGarbageNodes()
    self.inTok = inTok
    assert(inTok.text == "in")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndCapture: ExpressibleAsGarbageNodes? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    garbageBetweenCaptureAndInput: ExpressibleAsGarbageNodes? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    garbageBetweenInputAndAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: String?,
    garbageBetweenAsyncKeywordAndThrowsTok: ExpressibleAsGarbageNodes? = nil,
    throwsTok: TokenSyntax? = nil,
    garbageBetweenThrowsTokAndOutput: ExpressibleAsGarbageNodes? = nil,
    output: ExpressibleAsReturnClause? = nil,
    garbageBetweenOutputAndInTok: ExpressibleAsGarbageNodes? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndCapture: garbageBetweenAttributesAndCapture,
      capture: capture,
      garbageBetweenCaptureAndInput: garbageBetweenCaptureAndInput,
      input: input,
      garbageBetweenInputAndAsyncKeyword: garbageBetweenInputAndAsyncKeyword,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      garbageBetweenAsyncKeywordAndThrowsTok: garbageBetweenAsyncKeywordAndThrowsTok,
      throwsTok: throwsTok,
      garbageBetweenThrowsTokAndOutput: garbageBetweenThrowsTokAndOutput,
      output: output,
      garbageBetweenOutputAndInTok: garbageBetweenOutputAndInTok,
      inTok: inTok
    )
  }

  /// Builds a `ClosureSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureSignatureSyntax`.
  func buildClosureSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureSignatureSyntax {
    let result = SyntaxFactory.makeClosureSignature(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndCapture?.buildGarbageNodes(format: format, leadingTrivia: nil),
      capture: capture?.buildClosureCaptureSignature(format: format, leadingTrivia: nil),
      garbageBetweenCaptureAndInput?.buildGarbageNodes(format: format, leadingTrivia: nil),
      input: input?.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenInputAndAsyncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      garbageBetweenAsyncKeywordAndThrowsTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwsTok: throwsTok,
      garbageBetweenThrowsTokAndOutput?.buildGarbageNodes(format: format, leadingTrivia: nil),
      output: output?.buildReturnClause(format: format, leadingTrivia: nil),
      garbageBetweenOutputAndInTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inTok: inTok
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureSignature(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureSignature`.
  public func createClosureSignature() -> ClosureSignature {
    return self
  }

  /// `ClosureSignature` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ClosureExpr: ExprBuildable, ExpressibleAsClosureExpr {
  let garbageBeforeLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndSignature: GarbageNodes?
  let signature: ClosureSignature?
  let garbageBetweenSignatureAndStatements: GarbageNodes?
  let statements: CodeBlockItemList
  let garbageBetweenStatementsAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndSignature: 
  ///   - signature: 
  ///   - garbageBetweenSignatureAndStatements: 
  ///   - statements: 
  ///   - garbageBetweenStatementsAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsClosureSignature? = nil,
    garbageBetweenSignatureAndStatements: ExpressibleAsGarbageNodes? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    garbageBetweenStatementsAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftBrace = garbageBeforeLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndSignature = garbageBetweenLeftBraceAndSignature?.createGarbageNodes()
    self.signature = signature?.createClosureSignature()
    self.garbageBetweenSignatureAndStatements = garbageBetweenSignatureAndStatements?.createGarbageNodes()
    self.statements = statements.createCodeBlockItemList()
    self.garbageBetweenStatementsAndRightBrace = garbageBetweenStatementsAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsClosureSignature? = nil,
    garbageBetweenSignatureAndStatements: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenStatementsAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftBrace: garbageBeforeLeftBrace,
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndSignature: garbageBetweenLeftBraceAndSignature,
      signature: signature,
      garbageBetweenSignatureAndStatements: garbageBetweenSignatureAndStatements,
      statements: statementsBuilder(),
      garbageBetweenStatementsAndRightBrace: garbageBetweenStatementsAndRightBrace,
      rightBrace: rightBrace
    )
  }

  /// Builds a `ClosureExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureExprSyntax`.
  func buildClosureExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureExprSyntax {
    let result = SyntaxFactory.makeClosureExpr(
      garbageBeforeLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndSignature?.buildGarbageNodes(format: format, leadingTrivia: nil),
      signature: signature?.buildClosureSignature(format: format, leadingTrivia: nil),
      garbageBetweenSignatureAndStatements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil),
      garbageBetweenStatementsAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildClosureExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsClosureExpr`.
  public func createClosureExpr() -> ClosureExpr {
    return self
  }

  /// `ClosureExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ClosureExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct UnresolvedPatternExpr: ExprBuildable, ExpressibleAsUnresolvedPatternExpr {
  let garbageBeforePattern: GarbageNodes?
  let pattern: PatternBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `UnresolvedPatternExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePattern: 
  ///   - pattern: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePattern = garbageBeforePattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
  }


  /// Builds a `UnresolvedPatternExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `UnresolvedPatternExprSyntax`.
  func buildUnresolvedPatternExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> UnresolvedPatternExprSyntax {
    let result = SyntaxFactory.makeUnresolvedPatternExpr(
      garbageBeforePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildUnresolvedPatternExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsUnresolvedPatternExpr`.
  public func createUnresolvedPatternExpr() -> UnresolvedPatternExpr {
    return self
  }

  /// `UnresolvedPatternExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `UnresolvedPatternExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MultipleTrailingClosureElement: SyntaxBuildable, ExpressibleAsMultipleTrailingClosureElement {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndClosure: GarbageNodes?
  let closure: ClosureExpr

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MultipleTrailingClosureElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: 
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndClosure: 
  ///   - closure: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndClosure: ExpressibleAsGarbageNodes? = nil,
    closure: ExpressibleAsClosureExpr
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndClosure = garbageBetweenColonAndClosure?.createGarbageNodes()
    self.closure = closure.createClosureExpr()
  }


  /// Builds a `MultipleTrailingClosureElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MultipleTrailingClosureElementSyntax`.
  func buildMultipleTrailingClosureElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementSyntax {
    let result = SyntaxFactory.makeMultipleTrailingClosureElement(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndClosure?.buildGarbageNodes(format: format, leadingTrivia: nil),
      closure: closure.buildClosureExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMultipleTrailingClosureElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsMultipleTrailingClosureElement`.
  public func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement {
    return self
  }

  /// `MultipleTrailingClosureElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct FunctionCallExpr: ExprBuildable, ExpressibleAsFunctionCallExpr {
  let garbageBeforeCalledExpression: GarbageNodes?
  let calledExpression: ExprBuildable
  let garbageBetweenCalledExpressionAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax?
  let garbageBetweenLeftParenAndArgumentList: GarbageNodes?
  let argumentList: TupleExprElementList
  let garbageBetweenArgumentListAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax?
  let garbageBetweenRightParenAndTrailingClosure: GarbageNodes?
  let trailingClosure: ClosureExpr?
  let garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodes?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionCallExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCalledExpression: 
  ///   - calledExpression: 
  ///   - garbageBetweenCalledExpressionAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArgumentList: 
  ///   - argumentList: 
  ///   - garbageBetweenArgumentListAndRightParen: 
  ///   - rightParen: 
  ///   - garbageBetweenRightParenAndTrailingClosure: 
  ///   - trailingClosure: 
  ///   - garbageBetweenTrailingClosureAndAdditionalTrailingClosures: 
  ///   - additionalTrailingClosures: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCalledExpression: ExpressibleAsGarbageNodes? = nil,
    calledExpression: ExpressibleAsExprBuildable,
    garbageBetweenCalledExpressionAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    argumentList: ExpressibleAsTupleExprElementList,
    garbageBetweenArgumentListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil,
    garbageBetweenRightParenAndTrailingClosure: ExpressibleAsGarbageNodes? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    garbageBetweenTrailingClosureAndAdditionalTrailingClosures: ExpressibleAsGarbageNodes? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCalledExpression = garbageBeforeCalledExpression?.createGarbageNodes()
    self.calledExpression = calledExpression.createExprBuildable()
    self.garbageBetweenCalledExpressionAndLeftParen = garbageBetweenCalledExpressionAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.garbageBetweenLeftParenAndArgumentList = garbageBetweenLeftParenAndArgumentList?.createGarbageNodes()
    self.argumentList = argumentList.createTupleExprElementList()
    self.garbageBetweenArgumentListAndRightParen = garbageBetweenArgumentListAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
    self.garbageBetweenRightParenAndTrailingClosure = garbageBetweenRightParenAndTrailingClosure?.createGarbageNodes()
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.garbageBetweenTrailingClosureAndAdditionalTrailingClosures = garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.createGarbageNodes()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCalledExpression: ExpressibleAsGarbageNodes? = nil,
    calledExpression: ExpressibleAsExprBuildable,
    garbageBetweenCalledExpressionAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenArgumentListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil,
    garbageBetweenRightParenAndTrailingClosure: ExpressibleAsGarbageNodes? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    garbageBetweenTrailingClosureAndAdditionalTrailingClosures: ExpressibleAsGarbageNodes? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeCalledExpression: garbageBeforeCalledExpression,
      calledExpression: calledExpression,
      garbageBetweenCalledExpressionAndLeftParen: garbageBetweenCalledExpressionAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgumentList: garbageBetweenLeftParenAndArgumentList,
      argumentList: argumentListBuilder(),
      garbageBetweenArgumentListAndRightParen: garbageBetweenArgumentListAndRightParen,
      rightParen: rightParen,
      garbageBetweenRightParenAndTrailingClosure: garbageBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures: garbageBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }

  /// Builds a `FunctionCallExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionCallExprSyntax`.
  func buildFunctionCallExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionCallExprSyntax {
    let result = SyntaxFactory.makeFunctionCallExpr(
      garbageBeforeCalledExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenCalledExpressionAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgumentList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentListAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      garbageBetweenRightParenAndTrailingClosure?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.buildGarbageNodes(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildFunctionCallExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionCallExpr`.
  public func createFunctionCallExpr() -> FunctionCallExpr {
    return self
  }

  /// `FunctionCallExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `FunctionCallExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SubscriptExpr: ExprBuildable, ExpressibleAsSubscriptExpr {
  let garbageBeforeCalledExpression: GarbageNodes?
  let calledExpression: ExprBuildable
  let garbageBetweenCalledExpressionAndLeftBracket: GarbageNodes?
  let leftBracket: TokenSyntax
  let garbageBetweenLeftBracketAndArgumentList: GarbageNodes?
  let argumentList: TupleExprElementList
  let garbageBetweenArgumentListAndRightBracket: GarbageNodes?
  let rightBracket: TokenSyntax
  let garbageBetweenRightBracketAndTrailingClosure: GarbageNodes?
  let trailingClosure: ClosureExpr?
  let garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodes?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SubscriptExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCalledExpression: 
  ///   - calledExpression: 
  ///   - garbageBetweenCalledExpressionAndLeftBracket: 
  ///   - leftBracket: 
  ///   - garbageBetweenLeftBracketAndArgumentList: 
  ///   - argumentList: 
  ///   - garbageBetweenArgumentListAndRightBracket: 
  ///   - rightBracket: 
  ///   - garbageBetweenRightBracketAndTrailingClosure: 
  ///   - trailingClosure: 
  ///   - garbageBetweenTrailingClosureAndAdditionalTrailingClosures: 
  ///   - additionalTrailingClosures: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCalledExpression: ExpressibleAsGarbageNodes? = nil,
    calledExpression: ExpressibleAsExprBuildable,
    garbageBetweenCalledExpressionAndLeftBracket: ExpressibleAsGarbageNodes? = nil,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftBracketAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    argumentList: ExpressibleAsTupleExprElementList,
    garbageBetweenArgumentListAndRightBracket: ExpressibleAsGarbageNodes? = nil,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    garbageBetweenRightBracketAndTrailingClosure: ExpressibleAsGarbageNodes? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    garbageBetweenTrailingClosureAndAdditionalTrailingClosures: ExpressibleAsGarbageNodes? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCalledExpression = garbageBeforeCalledExpression?.createGarbageNodes()
    self.calledExpression = calledExpression.createExprBuildable()
    self.garbageBetweenCalledExpressionAndLeftBracket = garbageBetweenCalledExpressionAndLeftBracket?.createGarbageNodes()
    self.leftBracket = leftBracket
    assert(leftBracket.text == "[")
    self.garbageBetweenLeftBracketAndArgumentList = garbageBetweenLeftBracketAndArgumentList?.createGarbageNodes()
    self.argumentList = argumentList.createTupleExprElementList()
    self.garbageBetweenArgumentListAndRightBracket = garbageBetweenArgumentListAndRightBracket?.createGarbageNodes()
    self.rightBracket = rightBracket
    assert(rightBracket.text == "]")
    self.garbageBetweenRightBracketAndTrailingClosure = garbageBetweenRightBracketAndTrailingClosure?.createGarbageNodes()
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.garbageBetweenTrailingClosureAndAdditionalTrailingClosures = garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.createGarbageNodes()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCalledExpression: ExpressibleAsGarbageNodes? = nil,
    calledExpression: ExpressibleAsExprBuildable,
    garbageBetweenCalledExpressionAndLeftBracket: ExpressibleAsGarbageNodes? = nil,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftBracketAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenArgumentListAndRightBracket: ExpressibleAsGarbageNodes? = nil,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    garbageBetweenRightBracketAndTrailingClosure: ExpressibleAsGarbageNodes? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    garbageBetweenTrailingClosureAndAdditionalTrailingClosures: ExpressibleAsGarbageNodes? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeCalledExpression: garbageBeforeCalledExpression,
      calledExpression: calledExpression,
      garbageBetweenCalledExpressionAndLeftBracket: garbageBetweenCalledExpressionAndLeftBracket,
      leftBracket: leftBracket,
      garbageBetweenLeftBracketAndArgumentList: garbageBetweenLeftBracketAndArgumentList,
      argumentList: argumentListBuilder(),
      garbageBetweenArgumentListAndRightBracket: garbageBetweenArgumentListAndRightBracket,
      rightBracket: rightBracket,
      garbageBetweenRightBracketAndTrailingClosure: garbageBetweenRightBracketAndTrailingClosure,
      trailingClosure: trailingClosure,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures: garbageBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }

  /// Builds a `SubscriptExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SubscriptExprSyntax`.
  func buildSubscriptExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SubscriptExprSyntax {
    let result = SyntaxFactory.makeSubscriptExpr(
      garbageBeforeCalledExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenCalledExpressionAndLeftBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBracket: leftBracket,
      garbageBetweenLeftBracketAndArgumentList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentListAndRightBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBracket: rightBracket,
      garbageBetweenRightBracketAndTrailingClosure?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.buildGarbageNodes(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSubscriptExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsSubscriptExpr`.
  public func createSubscriptExpr() -> SubscriptExpr {
    return self
  }

  /// `SubscriptExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `SubscriptExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct OptionalChainingExpr: ExprBuildable, ExpressibleAsOptionalChainingExpr {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndQuestionMark: GarbageNodes?
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalChainingExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndQuestionMark: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndQuestionMark: ExpressibleAsGarbageNodes? = nil,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndQuestionMark = garbageBetweenExpressionAndQuestionMark?.createGarbageNodes()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalChainingExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalChainingExprSyntax`.
  func buildOptionalChainingExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalChainingExprSyntax {
    let result = SyntaxFactory.makeOptionalChainingExpr(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndQuestionMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildOptionalChainingExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsOptionalChainingExpr`.
  public func createOptionalChainingExpr() -> OptionalChainingExpr {
    return self
  }

  /// `OptionalChainingExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `OptionalChainingExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ForcedValueExpr: ExprBuildable, ExpressibleAsForcedValueExpr {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndExclamationMark: GarbageNodes?
  let exclamationMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ForcedValueExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndExclamationMark: 
  ///   - exclamationMark: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndExclamationMark: ExpressibleAsGarbageNodes? = nil,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndExclamationMark = garbageBetweenExpressionAndExclamationMark?.createGarbageNodes()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  /// Builds a `ForcedValueExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ForcedValueExprSyntax`.
  func buildForcedValueExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ForcedValueExprSyntax {
    let result = SyntaxFactory.makeForcedValueExpr(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndExclamationMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildForcedValueExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsForcedValueExpr`.
  public func createForcedValueExpr() -> ForcedValueExpr {
    return self
  }

  /// `ForcedValueExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ForcedValueExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PostfixUnaryExpr: ExprBuildable, ExpressibleAsPostfixUnaryExpr {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndOperatorToken: GarbageNodes?
  let operatorToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PostfixUnaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndOperatorToken: 
  ///   - operatorToken: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndOperatorToken: ExpressibleAsGarbageNodes? = nil,
    operatorToken: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndOperatorToken = garbageBetweenExpressionAndOperatorToken?.createGarbageNodes()
    self.operatorToken = operatorToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndOperatorToken: ExpressibleAsGarbageNodes? = nil,
    operatorToken: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeExpression: garbageBeforeExpression,
      expression: expression,
      garbageBetweenExpressionAndOperatorToken: garbageBetweenExpressionAndOperatorToken,
      operatorToken: TokenSyntax.postfixOperator(operatorToken)
    )
  }

  /// Builds a `PostfixUnaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PostfixUnaryExprSyntax`.
  func buildPostfixUnaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PostfixUnaryExprSyntax {
    let result = SyntaxFactory.makePostfixUnaryExpr(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndOperatorToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorToken: operatorToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPostfixUnaryExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPostfixUnaryExpr`.
  public func createPostfixUnaryExpr() -> PostfixUnaryExpr {
    return self
  }

  /// `PostfixUnaryExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PostfixUnaryExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SpecializeExpr: ExprBuildable, ExpressibleAsSpecializeExpr {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndGenericArgumentClause: GarbageNodes?
  let genericArgumentClause: GenericArgumentClause

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SpecializeExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndGenericArgumentClause: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndGenericArgumentClause: ExpressibleAsGarbageNodes? = nil,
    genericArgumentClause: ExpressibleAsGenericArgumentClause
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndGenericArgumentClause = garbageBetweenExpressionAndGenericArgumentClause?.createGarbageNodes()
    self.genericArgumentClause = genericArgumentClause.createGenericArgumentClause()
  }


  /// Builds a `SpecializeExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SpecializeExprSyntax`.
  func buildSpecializeExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SpecializeExprSyntax {
    let result = SyntaxFactory.makeSpecializeExpr(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndGenericArgumentClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSpecializeExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsSpecializeExpr`.
  public func createSpecializeExpr() -> SpecializeExpr {
    return self
  }

  /// `SpecializeExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `SpecializeExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct StringSegment: SyntaxBuildable, ExpressibleAsStringSegment {
  let garbageBeforeContent: GarbageNodes?
  let content: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StringSegment` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeContent: 
  ///   - content: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeContent: ExpressibleAsGarbageNodes? = nil,
    content: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeContent = garbageBeforeContent?.createGarbageNodes()
    self.content = content
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeContent: ExpressibleAsGarbageNodes? = nil,
    content: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeContent: garbageBeforeContent,
      content: TokenSyntax.stringSegment(content)
    )
  }

  /// Builds a `StringSegmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StringSegmentSyntax`.
  func buildStringSegment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StringSegmentSyntax {
    let result = SyntaxFactory.makeStringSegment(
      garbageBeforeContent?.buildGarbageNodes(format: format, leadingTrivia: nil),
      content: content
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildStringSegment(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsStringSegment`.
  public func createStringSegment() -> StringSegment {
    return self
  }

  /// `StringSegment` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ExpressionSegment: SyntaxBuildable, ExpressibleAsExpressionSegment {
  let garbageBeforeBackslash: GarbageNodes?
  let backslash: TokenSyntax
  let garbageBetweenBackslashAndDelimiter: GarbageNodes?
  let delimiter: TokenSyntax?
  let garbageBetweenDelimiterAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndExpressions: GarbageNodes?
  let expressions: TupleExprElementList
  let garbageBetweenExpressionsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionSegment` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBackslash: 
  ///   - backslash: 
  ///   - garbageBetweenBackslashAndDelimiter: 
  ///   - delimiter: 
  ///   - garbageBetweenDelimiterAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndExpressions: 
  ///   - expressions: 
  ///   - garbageBetweenExpressionsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBackslash: ExpressibleAsGarbageNodes? = nil,
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    garbageBetweenBackslashAndDelimiter: ExpressibleAsGarbageNodes? = nil,
    delimiter: TokenSyntax? = nil,
    garbageBetweenDelimiterAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndExpressions: ExpressibleAsGarbageNodes? = nil,
    expressions: ExpressibleAsTupleExprElementList,
    garbageBetweenExpressionsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBackslash = garbageBeforeBackslash?.createGarbageNodes()
    self.backslash = backslash
    assert(backslash.text == "\\")
    self.garbageBetweenBackslashAndDelimiter = garbageBetweenBackslashAndDelimiter?.createGarbageNodes()
    self.delimiter = delimiter
    self.garbageBetweenDelimiterAndLeftParen = garbageBetweenDelimiterAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndExpressions = garbageBetweenLeftParenAndExpressions?.createGarbageNodes()
    self.expressions = expressions.createTupleExprElementList()
    self.garbageBetweenExpressionsAndRightParen = garbageBetweenExpressionsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBackslash: ExpressibleAsGarbageNodes? = nil,
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    garbageBetweenBackslashAndDelimiter: ExpressibleAsGarbageNodes? = nil,
    delimiter: String?,
    garbageBetweenDelimiterAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndExpressions: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenExpressionsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
    @TupleExprElementListBuilder expressionsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeBackslash: garbageBeforeBackslash,
      backslash: backslash,
      garbageBetweenBackslashAndDelimiter: garbageBetweenBackslashAndDelimiter,
      delimiter: delimiter.map(TokenSyntax.rawStringDelimiter),
      garbageBetweenDelimiterAndLeftParen: garbageBetweenDelimiterAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndExpressions: garbageBetweenLeftParenAndExpressions,
      expressions: expressionsBuilder(),
      garbageBetweenExpressionsAndRightParen: garbageBetweenExpressionsAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `ExpressionSegmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionSegmentSyntax`.
  func buildExpressionSegment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionSegmentSyntax {
    let result = SyntaxFactory.makeExpressionSegment(
      garbageBeforeBackslash?.buildGarbageNodes(format: format, leadingTrivia: nil),
      backslash: backslash,
      garbageBetweenBackslashAndDelimiter?.buildGarbageNodes(format: format, leadingTrivia: nil),
      delimiter: delimiter,
      garbageBetweenDelimiterAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndExpressions?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expressions: expressions.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenExpressionsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildExpressionSegment(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsExpressionSegment`.
  public func createExpressionSegment() -> ExpressionSegment {
    return self
  }

  /// `ExpressionSegment` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct StringLiteralExpr: ExprBuildable, ExpressibleAsStringLiteralExpr {
  let garbageBeforeOpenDelimiter: GarbageNodes?
  let openDelimiter: TokenSyntax?
  let garbageBetweenOpenDelimiterAndOpenQuote: GarbageNodes?
  let openQuote: TokenSyntax
  let garbageBetweenOpenQuoteAndSegments: GarbageNodes?
  let segments: StringLiteralSegments
  let garbageBetweenSegmentsAndCloseQuote: GarbageNodes?
  let closeQuote: TokenSyntax
  let garbageBetweenCloseQuoteAndCloseDelimiter: GarbageNodes?
  let closeDelimiter: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StringLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeOpenDelimiter: 
  ///   - openDelimiter: 
  ///   - garbageBetweenOpenDelimiterAndOpenQuote: 
  ///   - openQuote: 
  ///   - garbageBetweenOpenQuoteAndSegments: 
  ///   - segments: 
  ///   - garbageBetweenSegmentsAndCloseQuote: 
  ///   - closeQuote: 
  ///   - garbageBetweenCloseQuoteAndCloseDelimiter: 
  ///   - closeDelimiter: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOpenDelimiter: ExpressibleAsGarbageNodes? = nil,
    openDelimiter: TokenSyntax? = nil,
    garbageBetweenOpenDelimiterAndOpenQuote: ExpressibleAsGarbageNodes? = nil,
    openQuote: TokenSyntax,
    garbageBetweenOpenQuoteAndSegments: ExpressibleAsGarbageNodes? = nil,
    segments: ExpressibleAsStringLiteralSegments,
    garbageBetweenSegmentsAndCloseQuote: ExpressibleAsGarbageNodes? = nil,
    closeQuote: TokenSyntax,
    garbageBetweenCloseQuoteAndCloseDelimiter: ExpressibleAsGarbageNodes? = nil,
    closeDelimiter: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeOpenDelimiter = garbageBeforeOpenDelimiter?.createGarbageNodes()
    self.openDelimiter = openDelimiter
    self.garbageBetweenOpenDelimiterAndOpenQuote = garbageBetweenOpenDelimiterAndOpenQuote?.createGarbageNodes()
    self.openQuote = openQuote
    assert(openQuote.text == "\"" || openQuote.text == "\"\"\"")
    self.garbageBetweenOpenQuoteAndSegments = garbageBetweenOpenQuoteAndSegments?.createGarbageNodes()
    self.segments = segments.createStringLiteralSegments()
    self.garbageBetweenSegmentsAndCloseQuote = garbageBetweenSegmentsAndCloseQuote?.createGarbageNodes()
    self.closeQuote = closeQuote
    assert(closeQuote.text == "\"" || closeQuote.text == "\"\"\"")
    self.garbageBetweenCloseQuoteAndCloseDelimiter = garbageBetweenCloseQuoteAndCloseDelimiter?.createGarbageNodes()
    self.closeDelimiter = closeDelimiter
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOpenDelimiter: ExpressibleAsGarbageNodes? = nil,
    openDelimiter: String?,
    garbageBetweenOpenDelimiterAndOpenQuote: ExpressibleAsGarbageNodes? = nil,
    openQuote: TokenSyntax,
    garbageBetweenOpenQuoteAndSegments: ExpressibleAsGarbageNodes? = nil,
    segments: ExpressibleAsStringLiteralSegments,
    garbageBetweenSegmentsAndCloseQuote: ExpressibleAsGarbageNodes? = nil,
    closeQuote: TokenSyntax,
    garbageBetweenCloseQuoteAndCloseDelimiter: ExpressibleAsGarbageNodes? = nil,
    closeDelimiter: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeOpenDelimiter: garbageBeforeOpenDelimiter,
      openDelimiter: openDelimiter.map(TokenSyntax.rawStringDelimiter),
      garbageBetweenOpenDelimiterAndOpenQuote: garbageBetweenOpenDelimiterAndOpenQuote,
      openQuote: openQuote,
      garbageBetweenOpenQuoteAndSegments: garbageBetweenOpenQuoteAndSegments,
      segments: segments,
      garbageBetweenSegmentsAndCloseQuote: garbageBetweenSegmentsAndCloseQuote,
      closeQuote: closeQuote,
      garbageBetweenCloseQuoteAndCloseDelimiter: garbageBetweenCloseQuoteAndCloseDelimiter,
      closeDelimiter: closeDelimiter.map(TokenSyntax.rawStringDelimiter)
    )
  }

  /// Builds a `StringLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StringLiteralExprSyntax`.
  func buildStringLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StringLiteralExprSyntax {
    let result = SyntaxFactory.makeStringLiteralExpr(
      garbageBeforeOpenDelimiter?.buildGarbageNodes(format: format, leadingTrivia: nil),
      openDelimiter: openDelimiter,
      garbageBetweenOpenDelimiterAndOpenQuote?.buildGarbageNodes(format: format, leadingTrivia: nil),
      openQuote: openQuote,
      garbageBetweenOpenQuoteAndSegments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      segments: segments.buildStringLiteralSegments(format: format, leadingTrivia: nil),
      garbageBetweenSegmentsAndCloseQuote?.buildGarbageNodes(format: format, leadingTrivia: nil),
      closeQuote: closeQuote,
      garbageBetweenCloseQuoteAndCloseDelimiter?.buildGarbageNodes(format: format, leadingTrivia: nil),
      closeDelimiter: closeDelimiter
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildStringLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsStringLiteralExpr`.
  public func createStringLiteralExpr() -> StringLiteralExpr {
    return self
  }

  /// `StringLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `StringLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct RegexLiteralExpr: ExprBuildable, ExpressibleAsRegexLiteralExpr {
  let garbageBeforeRegex: GarbageNodes?
  let regex: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `RegexLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeRegex: 
  ///   - regex: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeRegex: ExpressibleAsGarbageNodes? = nil,
    regex: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeRegex = garbageBeforeRegex?.createGarbageNodes()
    self.regex = regex
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeRegex: ExpressibleAsGarbageNodes? = nil,
    regex: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeRegex: garbageBeforeRegex,
      regex: TokenSyntax.regexLiteral(regex)
    )
  }

  /// Builds a `RegexLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `RegexLiteralExprSyntax`.
  func buildRegexLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> RegexLiteralExprSyntax {
    let result = SyntaxFactory.makeRegexLiteralExpr(
      garbageBeforeRegex?.buildGarbageNodes(format: format, leadingTrivia: nil),
      regex: regex
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildRegexLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsRegexLiteralExpr`.
  public func createRegexLiteralExpr() -> RegexLiteralExpr {
    return self
  }

  /// `RegexLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `RegexLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct KeyPathExpr: ExprBuildable, ExpressibleAsKeyPathExpr {
  let garbageBeforeBackslash: GarbageNodes?
  let backslash: TokenSyntax
  let garbageBetweenBackslashAndRootExpr: GarbageNodes?
  let rootExpr: ExprBuildable?
  let garbageBetweenRootExprAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `KeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBackslash: 
  ///   - backslash: 
  ///   - garbageBetweenBackslashAndRootExpr: 
  ///   - rootExpr: 
  ///   - garbageBetweenRootExprAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBackslash: ExpressibleAsGarbageNodes? = nil,
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    garbageBetweenBackslashAndRootExpr: ExpressibleAsGarbageNodes? = nil,
    rootExpr: ExpressibleAsExprBuildable? = nil,
    garbageBetweenRootExprAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBackslash = garbageBeforeBackslash?.createGarbageNodes()
    self.backslash = backslash
    assert(backslash.text == "\\")
    self.garbageBetweenBackslashAndRootExpr = garbageBetweenBackslashAndRootExpr?.createGarbageNodes()
    self.rootExpr = rootExpr?.createExprBuildable()
    self.garbageBetweenRootExprAndExpression = garbageBetweenRootExprAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `KeyPathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `KeyPathExprSyntax`.
  func buildKeyPathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> KeyPathExprSyntax {
    let result = SyntaxFactory.makeKeyPathExpr(
      garbageBeforeBackslash?.buildGarbageNodes(format: format, leadingTrivia: nil),
      backslash: backslash,
      garbageBetweenBackslashAndRootExpr?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rootExpr: rootExpr?.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenRootExprAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildKeyPathExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsKeyPathExpr`.
  public func createKeyPathExpr() -> KeyPathExpr {
    return self
  }

  /// `KeyPathExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `KeyPathExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct KeyPathBaseExpr: ExprBuildable, ExpressibleAsKeyPathBaseExpr {
  let garbageBeforePeriod: GarbageNodes?
  let period: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `KeyPathBaseExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePeriod: 
  ///   - period: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax = TokenSyntax.`period`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePeriod = garbageBeforePeriod?.createGarbageNodes()
    self.period = period
    assert(period.text == ".")
  }


  /// Builds a `KeyPathBaseExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `KeyPathBaseExprSyntax`.
  func buildKeyPathBaseExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> KeyPathBaseExprSyntax {
    let result = SyntaxFactory.makeKeyPathBaseExpr(
      garbageBeforePeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      period: period
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildKeyPathBaseExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsKeyPathBaseExpr`.
  public func createKeyPathBaseExpr() -> KeyPathBaseExpr {
    return self
  }

  /// `KeyPathBaseExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `KeyPathBaseExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ObjcNamePiece: SyntaxBuildable, ExpressibleAsObjcNamePiece {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndDot: GarbageNodes?
  let dot: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcNamePiece` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndDot: 
  ///   - dot: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndDot: ExpressibleAsGarbageNodes? = nil,
    dot: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndDot = garbageBetweenNameAndDot?.createGarbageNodes()
    self.dot = dot
    assert(dot == nil || dot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndDot: ExpressibleAsGarbageNodes? = nil,
    dot: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndDot: garbageBetweenNameAndDot,
      dot: dot
    )
  }

  /// Builds a `ObjcNamePieceSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcNamePieceSyntax`.
  func buildObjcNamePiece(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcNamePieceSyntax {
    let result = SyntaxFactory.makeObjcNamePiece(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndDot?.buildGarbageNodes(format: format, leadingTrivia: nil),
      dot: dot
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildObjcNamePiece(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsObjcNamePiece`.
  public func createObjcNamePiece() -> ObjcNamePiece {
    return self
  }

  /// `ObjcNamePiece` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ObjcKeyPathExpr: ExprBuildable, ExpressibleAsObjcKeyPathExpr {
  let garbageBeforeKeyPath: GarbageNodes?
  let keyPath: TokenSyntax
  let garbageBetweenKeyPathAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndName: GarbageNodes?
  let name: ObjcName
  let garbageBetweenNameAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcKeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeKeyPath: 
  ///   - keyPath: 
  ///   - garbageBetweenKeyPathAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeKeyPath: ExpressibleAsGarbageNodes? = nil,
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    garbageBetweenKeyPathAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndName: ExpressibleAsGarbageNodes? = nil,
    name: ExpressibleAsObjcName,
    garbageBetweenNameAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeKeyPath = garbageBeforeKeyPath?.createGarbageNodes()
    self.keyPath = keyPath
    assert(keyPath.text == "#keyPath")
    self.garbageBetweenKeyPathAndLeftParen = garbageBetweenKeyPathAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndName = garbageBetweenLeftParenAndName?.createGarbageNodes()
    self.name = name.createObjcName()
    self.garbageBetweenNameAndRightParen = garbageBetweenNameAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `ObjcKeyPathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcKeyPathExprSyntax`.
  func buildObjcKeyPathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcKeyPathExprSyntax {
    let result = SyntaxFactory.makeObjcKeyPathExpr(
      garbageBeforeKeyPath?.buildGarbageNodes(format: format, leadingTrivia: nil),
      keyPath: keyPath,
      garbageBetweenKeyPathAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name.buildObjcName(format: format, leadingTrivia: nil),
      garbageBetweenNameAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjcKeyPathExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsObjcKeyPathExpr`.
  public func createObjcKeyPathExpr() -> ObjcKeyPathExpr {
    return self
  }

  /// `ObjcKeyPathExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ObjcKeyPathExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ObjcSelectorExpr: ExprBuildable, ExpressibleAsObjcSelectorExpr {
  let garbageBeforePoundSelector: GarbageNodes?
  let poundSelector: TokenSyntax
  let garbageBetweenPoundSelectorAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndKind: GarbageNodes?
  let kind: TokenSyntax?
  let garbageBetweenKindAndColon: GarbageNodes?
  let colon: TokenSyntax?
  let garbageBetweenColonAndName: GarbageNodes?
  let name: ExprBuildable
  let garbageBetweenNameAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcSelectorExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundSelector: 
  ///   - poundSelector: 
  ///   - garbageBetweenPoundSelectorAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndKind: 
  ///   - kind: 
  ///   - garbageBetweenKindAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundSelector: ExpressibleAsGarbageNodes? = nil,
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    garbageBetweenPoundSelectorAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndKind: ExpressibleAsGarbageNodes? = nil,
    kind: TokenSyntax? = nil,
    garbageBetweenKindAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndName: ExpressibleAsGarbageNodes? = nil,
    name: ExpressibleAsExprBuildable,
    garbageBetweenNameAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundSelector = garbageBeforePoundSelector?.createGarbageNodes()
    self.poundSelector = poundSelector
    assert(poundSelector.text == "#selector")
    self.garbageBetweenPoundSelectorAndLeftParen = garbageBetweenPoundSelectorAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndKind = garbageBetweenLeftParenAndKind?.createGarbageNodes()
    self.kind = kind
    assert(kind == nil || kind!.text == "getter" || kind!.text == "setter")
    self.garbageBetweenKindAndColon = garbageBetweenKindAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.garbageBetweenColonAndName = garbageBetweenColonAndName?.createGarbageNodes()
    self.name = name.createExprBuildable()
    self.garbageBetweenNameAndRightParen = garbageBetweenNameAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundSelector: ExpressibleAsGarbageNodes? = nil,
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    garbageBetweenPoundSelectorAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndKind: ExpressibleAsGarbageNodes? = nil,
    kind: String?,
    garbageBetweenKindAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndName: ExpressibleAsGarbageNodes? = nil,
    name: ExpressibleAsExprBuildable,
    garbageBetweenNameAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforePoundSelector: garbageBeforePoundSelector,
      poundSelector: poundSelector,
      garbageBetweenPoundSelectorAndLeftParen: garbageBetweenPoundSelectorAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndKind: garbageBetweenLeftParenAndKind,
      kind: kind.map(TokenSyntax.contextualKeyword),
      garbageBetweenKindAndColon: garbageBetweenKindAndColon,
      colon: colon,
      garbageBetweenColonAndName: garbageBetweenColonAndName,
      name: name,
      garbageBetweenNameAndRightParen: garbageBetweenNameAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `ObjcSelectorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcSelectorExprSyntax`.
  func buildObjcSelectorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcSelectorExprSyntax {
    let result = SyntaxFactory.makeObjcSelectorExpr(
      garbageBeforePoundSelector?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundSelector: poundSelector,
      garbageBetweenPoundSelectorAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndKind?.buildGarbageNodes(format: format, leadingTrivia: nil),
      kind: kind,
      garbageBetweenKindAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenNameAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjcSelectorExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsObjcSelectorExpr`.
  public func createObjcSelectorExpr() -> ObjcSelectorExpr {
    return self
  }

  /// `ObjcSelectorExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ObjcSelectorExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PostfixIfConfigExpr: ExprBuildable, ExpressibleAsPostfixIfConfigExpr {
  let garbageBeforeBase: GarbageNodes?
  let base: ExprBuildable?
  let garbageBetweenBaseAndConfig: GarbageNodes?
  let config: IfConfigDecl

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PostfixIfConfigExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBase: 
  ///   - base: 
  ///   - garbageBetweenBaseAndConfig: 
  ///   - config: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBase: ExpressibleAsGarbageNodes? = nil,
    base: ExpressibleAsExprBuildable? = nil,
    garbageBetweenBaseAndConfig: ExpressibleAsGarbageNodes? = nil,
    config: ExpressibleAsIfConfigDecl
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBase = garbageBeforeBase?.createGarbageNodes()
    self.base = base?.createExprBuildable()
    self.garbageBetweenBaseAndConfig = garbageBetweenBaseAndConfig?.createGarbageNodes()
    self.config = config.createIfConfigDecl()
  }


  /// Builds a `PostfixIfConfigExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PostfixIfConfigExprSyntax`.
  func buildPostfixIfConfigExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PostfixIfConfigExprSyntax {
    let result = SyntaxFactory.makePostfixIfConfigExpr(
      garbageBeforeBase?.buildGarbageNodes(format: format, leadingTrivia: nil),
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenBaseAndConfig?.buildGarbageNodes(format: format, leadingTrivia: nil),
      config: config.buildIfConfigDecl(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPostfixIfConfigExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsPostfixIfConfigExpr`.
  public func createPostfixIfConfigExpr() -> PostfixIfConfigExpr {
    return self
  }

  /// `PostfixIfConfigExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `PostfixIfConfigExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct EditorPlaceholderExpr: ExprBuildable, ExpressibleAsEditorPlaceholderExpr {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EditorPlaceholderExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeIdentifier: garbageBeforeIdentifier,
      identifier: TokenSyntax.identifier(identifier)
    )
  }

  /// Builds a `EditorPlaceholderExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EditorPlaceholderExprSyntax`.
  func buildEditorPlaceholderExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EditorPlaceholderExprSyntax {
    let result = SyntaxFactory.makeEditorPlaceholderExpr(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildEditorPlaceholderExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsEditorPlaceholderExpr`.
  public func createEditorPlaceholderExpr() -> EditorPlaceholderExpr {
    return self
  }

  /// `EditorPlaceholderExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `EditorPlaceholderExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ObjectLiteralExpr: ExprBuildable, ExpressibleAsObjectLiteralExpr {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndArguments: GarbageNodes?
  let arguments: TupleExprElementList
  let garbageBetweenArgumentsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjectLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArguments: 
  ///   - arguments: 
  ///   - garbageBetweenArgumentsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsTupleExprElementList,
    garbageBetweenArgumentsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
    assert(identifier.text == "#colorLiteral" || identifier.text == "#fileLiteral" || identifier.text == "#imageLiteral")
    self.garbageBetweenIdentifierAndLeftParen = garbageBetweenIdentifierAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndArguments = garbageBetweenLeftParenAndArguments?.createGarbageNodes()
    self.arguments = arguments.createTupleExprElementList()
    self.garbageBetweenArgumentsAndRightParen = garbageBetweenArgumentsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndArguments: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenArgumentsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeIdentifier: garbageBeforeIdentifier,
      identifier: identifier,
      garbageBetweenIdentifierAndLeftParen: garbageBetweenIdentifierAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndArguments: garbageBetweenLeftParenAndArguments,
      arguments: argumentsBuilder(),
      garbageBetweenArgumentsAndRightParen: garbageBetweenArgumentsAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `ObjectLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjectLiteralExprSyntax`.
  func buildObjectLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjectLiteralExprSyntax {
    let result = SyntaxFactory.makeObjectLiteralExpr(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjectLiteralExpr(format: format, leadingTrivia: additionalLeadingTrivia)
    return ExprSyntax(result)
  }

  /// Conformance to `ExpressibleAsObjectLiteralExpr`.
  public func createObjectLiteralExpr() -> ObjectLiteralExpr {
    return self
  }

  /// `ObjectLiteralExpr` might conform to `ExpressibleAsExprBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createExprBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createExprBuildable() -> ExprBuildable {
    return self
  }

  /// `ObjectLiteralExpr` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TypeInitializerClause: SyntaxBuildable, ExpressibleAsTypeInitializerClause {
  let garbageBeforeEqual: GarbageNodes?
  let equal: TokenSyntax
  let garbageBetweenEqualAndValue: GarbageNodes?
  let value: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeInitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeEqual: 
  ///   - equal: 
  ///   - garbageBetweenEqualAndValue: 
  ///   - value: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeEqual: ExpressibleAsGarbageNodes? = nil,
    equal: TokenSyntax = TokenSyntax.`equal`,
    garbageBetweenEqualAndValue: ExpressibleAsGarbageNodes? = nil,
    value: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeEqual = garbageBeforeEqual?.createGarbageNodes()
    self.equal = equal
    assert(equal.text == "=")
    self.garbageBetweenEqualAndValue = garbageBetweenEqualAndValue?.createGarbageNodes()
    self.value = value.createTypeBuildable()
  }


  /// Builds a `TypeInitializerClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeInitializerClauseSyntax`.
  func buildTypeInitializerClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeInitializerClauseSyntax {
    let result = SyntaxFactory.makeTypeInitializerClause(
      garbageBeforeEqual?.buildGarbageNodes(format: format, leadingTrivia: nil),
      equal: equal,
      garbageBetweenEqualAndValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      value: value.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeInitializerClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTypeInitializerClause`.
  public func createTypeInitializerClause() -> TypeInitializerClause {
    return self
  }

  /// `TypeInitializerClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct TypealiasDecl: DeclBuildable, ExpressibleAsTypealiasDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndTypealiasKeyword: GarbageNodes?
  let typealiasKeyword: TokenSyntax
  let garbageBetweenTypealiasKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndInitializer: GarbageNodes?
  let initializer: TypeInitializerClause
  let garbageBetweenInitializerAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypealiasDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndTypealiasKeyword: 
  ///   - typealiasKeyword: 
  ///   - garbageBetweenTypealiasKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndInitializer: 
  ///   - initializer: 
  ///   - garbageBetweenInitializerAndGenericWhereClause: 
  ///   - genericWhereClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndTypealiasKeyword: ExpressibleAsGarbageNodes? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    garbageBetweenTypealiasKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsTypeInitializerClause,
    garbageBetweenInitializerAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndTypealiasKeyword = garbageBetweenModifiersAndTypealiasKeyword?.createGarbageNodes()
    self.typealiasKeyword = typealiasKeyword
    assert(typealiasKeyword.text == "typealias")
    self.garbageBetweenTypealiasKeywordAndIdentifier = garbageBetweenTypealiasKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameterClause = garbageBetweenIdentifierAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndInitializer = garbageBetweenGenericParameterClauseAndInitializer?.createGarbageNodes()
    self.initializer = initializer.createTypeInitializerClause()
    self.garbageBetweenInitializerAndGenericWhereClause = garbageBetweenInitializerAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndTypealiasKeyword: ExpressibleAsGarbageNodes? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    garbageBetweenTypealiasKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsTypeInitializerClause,
    garbageBetweenInitializerAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndTypealiasKeyword: garbageBetweenModifiersAndTypealiasKeyword,
      typealiasKeyword: typealiasKeyword,
      garbageBetweenTypealiasKeywordAndIdentifier: garbageBetweenTypealiasKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericParameterClause: garbageBetweenIdentifierAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndInitializer: garbageBetweenGenericParameterClauseAndInitializer,
      initializer: initializer,
      garbageBetweenInitializerAndGenericWhereClause: garbageBetweenInitializerAndGenericWhereClause,
      genericWhereClause: genericWhereClause
    )
  }

  /// Builds a `TypealiasDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypealiasDeclSyntax`.
  func buildTypealiasDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypealiasDeclSyntax {
    let result = SyntaxFactory.makeTypealiasDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndTypealiasKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typealiasKeyword: typealiasKeyword,
      garbageBetweenTypealiasKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenInitializerAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildTypealiasDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsTypealiasDecl`.
  public func createTypealiasDecl() -> TypealiasDecl {
    return self
  }

  /// `TypealiasDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `TypealiasDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AssociatedtypeDecl: DeclBuildable, ExpressibleAsAssociatedtypeDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndAssociatedtypeKeyword: GarbageNodes?
  let associatedtypeKeyword: TokenSyntax
  let garbageBetweenAssociatedtypeKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndInitializer: GarbageNodes?
  let initializer: TypeInitializerClause?
  let garbageBetweenInitializerAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AssociatedtypeDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndAssociatedtypeKeyword: 
  ///   - associatedtypeKeyword: 
  ///   - garbageBetweenAssociatedtypeKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndInitializer: 
  ///   - initializer: 
  ///   - garbageBetweenInitializerAndGenericWhereClause: 
  ///   - genericWhereClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndAssociatedtypeKeyword: ExpressibleAsGarbageNodes? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    garbageBetweenAssociatedtypeKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    garbageBetweenInitializerAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndAssociatedtypeKeyword = garbageBetweenModifiersAndAssociatedtypeKeyword?.createGarbageNodes()
    self.associatedtypeKeyword = associatedtypeKeyword
    assert(associatedtypeKeyword.text == "associatedtype")
    self.garbageBetweenAssociatedtypeKeywordAndIdentifier = garbageBetweenAssociatedtypeKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndInheritanceClause = garbageBetweenIdentifierAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndInitializer = garbageBetweenInheritanceClauseAndInitializer?.createGarbageNodes()
    self.initializer = initializer?.createTypeInitializerClause()
    self.garbageBetweenInitializerAndGenericWhereClause = garbageBetweenInitializerAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndAssociatedtypeKeyword: ExpressibleAsGarbageNodes? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    garbageBetweenAssociatedtypeKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    garbageBetweenInitializerAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndAssociatedtypeKeyword: garbageBetweenModifiersAndAssociatedtypeKeyword,
      associatedtypeKeyword: associatedtypeKeyword,
      garbageBetweenAssociatedtypeKeywordAndIdentifier: garbageBetweenAssociatedtypeKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndInheritanceClause: garbageBetweenIdentifierAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndInitializer: garbageBetweenInheritanceClauseAndInitializer,
      initializer: initializer,
      garbageBetweenInitializerAndGenericWhereClause: garbageBetweenInitializerAndGenericWhereClause,
      genericWhereClause: genericWhereClause
    )
  }

  /// Builds a `AssociatedtypeDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AssociatedtypeDeclSyntax`.
  func buildAssociatedtypeDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AssociatedtypeDeclSyntax {
    let result = SyntaxFactory.makeAssociatedtypeDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndAssociatedtypeKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      associatedtypeKeyword: associatedtypeKeyword,
      garbageBetweenAssociatedtypeKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenInitializerAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildAssociatedtypeDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsAssociatedtypeDecl`.
  public func createAssociatedtypeDecl() -> AssociatedtypeDecl {
    return self
  }

  /// `AssociatedtypeDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `AssociatedtypeDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ParameterClause: SyntaxBuildable, ExpressibleAsParameterClause {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndParameterList: GarbageNodes?
  let parameterList: FunctionParameterList
  let garbageBetweenParameterListAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndParameterList: 
  ///   - parameterList: 
  ///   - garbageBetweenParameterListAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndParameterList: ExpressibleAsGarbageNodes? = nil,
    parameterList: ExpressibleAsFunctionParameterList,
    garbageBetweenParameterListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndParameterList = garbageBetweenLeftParenAndParameterList?.createGarbageNodes()
    self.parameterList = parameterList.createFunctionParameterList()
    self.garbageBetweenParameterListAndRightParen = garbageBetweenParameterListAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndParameterList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenParameterListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> ExpressibleAsFunctionParameterList = { FunctionParameterList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndParameterList: garbageBetweenLeftParenAndParameterList,
      parameterList: parameterListBuilder(),
      garbageBetweenParameterListAndRightParen: garbageBetweenParameterListAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `ParameterClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ParameterClauseSyntax`.
  func buildParameterClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ParameterClauseSyntax {
    let result = SyntaxFactory.makeParameterClause(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndParameterList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      parameterList: parameterList.buildFunctionParameterList(format: format, leadingTrivia: nil),
      garbageBetweenParameterListAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildParameterClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsParameterClause`.
  public func createParameterClause() -> ParameterClause {
    return self
  }

  /// `ParameterClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ReturnClause: SyntaxBuildable, ExpressibleAsReturnClause {
  let garbageBeforeArrow: GarbageNodes?
  let arrow: TokenSyntax
  let garbageBetweenArrowAndReturnType: GarbageNodes?
  let returnType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ReturnClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeArrow: 
  ///   - arrow: 
  ///   - garbageBetweenArrowAndReturnType: 
  ///   - returnType: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeArrow: ExpressibleAsGarbageNodes? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    garbageBetweenArrowAndReturnType: ExpressibleAsGarbageNodes? = nil,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeArrow = garbageBeforeArrow?.createGarbageNodes()
    self.arrow = arrow
    assert(arrow.text == "->")
    self.garbageBetweenArrowAndReturnType = garbageBetweenArrowAndReturnType?.createGarbageNodes()
    self.returnType = returnType.createTypeBuildable()
  }


  /// Builds a `ReturnClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ReturnClauseSyntax`.
  func buildReturnClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ReturnClauseSyntax {
    let result = SyntaxFactory.makeReturnClause(
      garbageBeforeArrow?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arrow: arrow,
      garbageBetweenArrowAndReturnType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildReturnClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsReturnClause`.
  public func createReturnClause() -> ReturnClause {
    return self
  }

  /// `ReturnClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct FunctionSignature: SyntaxBuildable, ExpressibleAsFunctionSignature {
  let garbageBeforeInput: GarbageNodes?
  let input: ParameterClause
  let garbageBetweenInputAndAsyncOrReasyncKeyword: GarbageNodes?
  let asyncOrReasyncKeyword: TokenSyntax?
  let garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodes?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let garbageBetweenThrowsOrRethrowsKeywordAndOutput: GarbageNodes?
  let output: ReturnClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionSignature` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeInput: 
  ///   - input: 
  ///   - garbageBetweenInputAndAsyncOrReasyncKeyword: 
  ///   - asyncOrReasyncKeyword: 
  ///   - garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - garbageBetweenThrowsOrRethrowsKeywordAndOutput: 
  ///   - output: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeInput: ExpressibleAsGarbageNodes? = nil,
    input: ExpressibleAsParameterClause,
    garbageBetweenInputAndAsyncOrReasyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncOrReasyncKeyword: TokenSyntax? = nil,
    garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: ExpressibleAsGarbageNodes? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    garbageBetweenThrowsOrRethrowsKeywordAndOutput: ExpressibleAsGarbageNodes? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeInput = garbageBeforeInput?.createGarbageNodes()
    self.input = input.createParameterClause()
    self.garbageBetweenInputAndAsyncOrReasyncKeyword = garbageBetweenInputAndAsyncOrReasyncKeyword?.createGarbageNodes()
    self.asyncOrReasyncKeyword = asyncOrReasyncKeyword
    assert(asyncOrReasyncKeyword == nil || asyncOrReasyncKeyword!.text == "async" || asyncOrReasyncKeyword!.text == "reasync")
    self.garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword = garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.createGarbageNodes()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || throwsOrRethrowsKeyword!.text == "throws" || throwsOrRethrowsKeyword!.text == "rethrows")
    self.garbageBetweenThrowsOrRethrowsKeywordAndOutput = garbageBetweenThrowsOrRethrowsKeywordAndOutput?.createGarbageNodes()
    self.output = output?.createReturnClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeInput: ExpressibleAsGarbageNodes? = nil,
    input: ExpressibleAsParameterClause,
    garbageBetweenInputAndAsyncOrReasyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncOrReasyncKeyword: String?,
    garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: ExpressibleAsGarbageNodes? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    garbageBetweenThrowsOrRethrowsKeywordAndOutput: ExpressibleAsGarbageNodes? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeInput: garbageBeforeInput,
      input: input,
      garbageBetweenInputAndAsyncOrReasyncKeyword: garbageBetweenInputAndAsyncOrReasyncKeyword,
      asyncOrReasyncKeyword: asyncOrReasyncKeyword.map(TokenSyntax.contextualKeyword),
      garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      garbageBetweenThrowsOrRethrowsKeywordAndOutput: garbageBetweenThrowsOrRethrowsKeywordAndOutput,
      output: output
    )
  }

  /// Builds a `FunctionSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionSignatureSyntax`.
  func buildFunctionSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionSignatureSyntax {
    let result = SyntaxFactory.makeFunctionSignature(
      garbageBeforeInput?.buildGarbageNodes(format: format, leadingTrivia: nil),
      input: input.buildParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenInputAndAsyncOrReasyncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asyncOrReasyncKeyword: asyncOrReasyncKeyword,
      garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      garbageBetweenThrowsOrRethrowsKeywordAndOutput?.buildGarbageNodes(format: format, leadingTrivia: nil),
      output: output?.buildReturnClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionSignature(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionSignature`.
  public func createFunctionSignature() -> FunctionSignature {
    return self
  }

  /// `FunctionSignature` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct IfConfigClause: SyntaxBuildable, ExpressibleAsIfConfigClause {
  let garbageBeforePoundKeyword: GarbageNodes?
  let poundKeyword: TokenSyntax
  let garbageBetweenPoundKeywordAndCondition: GarbageNodes?
  let condition: ExprBuildable?
  let garbageBetweenConditionAndElements: GarbageNodes?
  let elements: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfConfigClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundKeyword: 
  ///   - poundKeyword: 
  ///   - garbageBetweenPoundKeywordAndCondition: 
  ///   - condition: 
  ///   - garbageBetweenConditionAndElements: 
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundKeyword: ExpressibleAsGarbageNodes? = nil,
    poundKeyword: TokenSyntax,
    garbageBetweenPoundKeywordAndCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsExprBuildable? = nil,
    garbageBetweenConditionAndElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundKeyword = garbageBeforePoundKeyword?.createGarbageNodes()
    self.poundKeyword = poundKeyword
    assert(poundKeyword.text == "#if" || poundKeyword.text == "#elseif" || poundKeyword.text == "#else")
    self.garbageBetweenPoundKeywordAndCondition = garbageBetweenPoundKeywordAndCondition?.createGarbageNodes()
    self.condition = condition?.createExprBuildable()
    self.garbageBetweenConditionAndElements = garbageBetweenConditionAndElements?.createGarbageNodes()
    self.elements = elements.createSyntaxBuildable()
  }


  /// Builds a `IfConfigClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfConfigClauseSyntax`.
  func buildIfConfigClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfConfigClauseSyntax {
    let result = SyntaxFactory.makeIfConfigClause(
      garbageBeforePoundKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundKeyword: poundKeyword,
      garbageBetweenPoundKeywordAndCondition?.buildGarbageNodes(format: format, leadingTrivia: nil),
      condition: condition?.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenConditionAndElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildIfConfigClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsIfConfigClause`.
  public func createIfConfigClause() -> IfConfigClause {
    return self
  }

  /// `IfConfigClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct IfConfigDecl: DeclBuildable, ExpressibleAsIfConfigDecl {
  let garbageBeforeClauses: GarbageNodes?
  let clauses: IfConfigClauseList
  let garbageBetweenClausesAndPoundEndif: GarbageNodes?
  let poundEndif: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfConfigDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeClauses: 
  ///   - clauses: 
  ///   - garbageBetweenClausesAndPoundEndif: 
  ///   - poundEndif: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeClauses: ExpressibleAsGarbageNodes? = nil,
    clauses: ExpressibleAsIfConfigClauseList,
    garbageBetweenClausesAndPoundEndif: ExpressibleAsGarbageNodes? = nil,
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeClauses = garbageBeforeClauses?.createGarbageNodes()
    self.clauses = clauses.createIfConfigClauseList()
    self.garbageBetweenClausesAndPoundEndif = garbageBetweenClausesAndPoundEndif?.createGarbageNodes()
    self.poundEndif = poundEndif
    assert(poundEndif.text == "#endif")
  }


  /// Builds a `IfConfigDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfConfigDeclSyntax`.
  func buildIfConfigDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfConfigDeclSyntax {
    let result = SyntaxFactory.makeIfConfigDecl(
      garbageBeforeClauses?.buildGarbageNodes(format: format, leadingTrivia: nil),
      clauses: clauses.buildIfConfigClauseList(format: format, leadingTrivia: nil),
      garbageBetweenClausesAndPoundEndif?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundEndif: poundEndif
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildIfConfigDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsIfConfigDecl`.
  public func createIfConfigDecl() -> IfConfigDecl {
    return self
  }

  /// `IfConfigDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `IfConfigDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundErrorDecl: DeclBuildable, ExpressibleAsPoundErrorDecl {
  let garbageBeforePoundError: GarbageNodes?
  let poundError: TokenSyntax
  let garbageBetweenPoundErrorAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndMessage: GarbageNodes?
  let message: StringLiteralExpr
  let garbageBetweenMessageAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundErrorDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundError: 
  ///   - poundError: 
  ///   - garbageBetweenPoundErrorAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndMessage: 
  ///   - message: 
  ///   - garbageBetweenMessageAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundError: ExpressibleAsGarbageNodes? = nil,
    poundError: TokenSyntax = TokenSyntax.`poundError`,
    garbageBetweenPoundErrorAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndMessage: ExpressibleAsGarbageNodes? = nil,
    message: ExpressibleAsStringLiteralExpr,
    garbageBetweenMessageAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundError = garbageBeforePoundError?.createGarbageNodes()
    self.poundError = poundError
    assert(poundError.text == "#error")
    self.garbageBetweenPoundErrorAndLeftParen = garbageBetweenPoundErrorAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndMessage = garbageBetweenLeftParenAndMessage?.createGarbageNodes()
    self.message = message.createStringLiteralExpr()
    self.garbageBetweenMessageAndRightParen = garbageBetweenMessageAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundErrorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundErrorDeclSyntax`.
  func buildPoundErrorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundErrorDeclSyntax {
    let result = SyntaxFactory.makePoundErrorDecl(
      garbageBeforePoundError?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundError: poundError,
      garbageBetweenPoundErrorAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndMessage?.buildGarbageNodes(format: format, leadingTrivia: nil),
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      garbageBetweenMessageAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundErrorDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundErrorDecl`.
  public func createPoundErrorDecl() -> PoundErrorDecl {
    return self
  }

  /// `PoundErrorDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `PoundErrorDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundWarningDecl: DeclBuildable, ExpressibleAsPoundWarningDecl {
  let garbageBeforePoundWarning: GarbageNodes?
  let poundWarning: TokenSyntax
  let garbageBetweenPoundWarningAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndMessage: GarbageNodes?
  let message: StringLiteralExpr
  let garbageBetweenMessageAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundWarningDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundWarning: 
  ///   - poundWarning: 
  ///   - garbageBetweenPoundWarningAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndMessage: 
  ///   - message: 
  ///   - garbageBetweenMessageAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundWarning: ExpressibleAsGarbageNodes? = nil,
    poundWarning: TokenSyntax = TokenSyntax.`poundWarning`,
    garbageBetweenPoundWarningAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndMessage: ExpressibleAsGarbageNodes? = nil,
    message: ExpressibleAsStringLiteralExpr,
    garbageBetweenMessageAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundWarning = garbageBeforePoundWarning?.createGarbageNodes()
    self.poundWarning = poundWarning
    assert(poundWarning.text == "#warning")
    self.garbageBetweenPoundWarningAndLeftParen = garbageBetweenPoundWarningAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndMessage = garbageBetweenLeftParenAndMessage?.createGarbageNodes()
    self.message = message.createStringLiteralExpr()
    self.garbageBetweenMessageAndRightParen = garbageBetweenMessageAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundWarningDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundWarningDeclSyntax`.
  func buildPoundWarningDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundWarningDeclSyntax {
    let result = SyntaxFactory.makePoundWarningDecl(
      garbageBeforePoundWarning?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundWarning: poundWarning,
      garbageBetweenPoundWarningAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndMessage?.buildGarbageNodes(format: format, leadingTrivia: nil),
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      garbageBetweenMessageAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundWarningDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundWarningDecl`.
  public func createPoundWarningDecl() -> PoundWarningDecl {
    return self
  }

  /// `PoundWarningDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `PoundWarningDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundSourceLocation: DeclBuildable, ExpressibleAsPoundSourceLocation {
  let garbageBeforePoundSourceLocation: GarbageNodes?
  let poundSourceLocation: TokenSyntax
  let garbageBetweenPoundSourceLocationAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndArgs: GarbageNodes?
  let args: PoundSourceLocationArgs?
  let garbageBetweenArgsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundSourceLocation` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundSourceLocation: 
  ///   - poundSourceLocation: 
  ///   - garbageBetweenPoundSourceLocationAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArgs: 
  ///   - args: 
  ///   - garbageBetweenArgsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundSourceLocation: ExpressibleAsGarbageNodes? = nil,
    poundSourceLocation: TokenSyntax = TokenSyntax.`poundSourceLocation`,
    garbageBetweenPoundSourceLocationAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndArgs: ExpressibleAsGarbageNodes? = nil,
    args: ExpressibleAsPoundSourceLocationArgs? = nil,
    garbageBetweenArgsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundSourceLocation = garbageBeforePoundSourceLocation?.createGarbageNodes()
    self.poundSourceLocation = poundSourceLocation
    assert(poundSourceLocation.text == "#sourceLocation")
    self.garbageBetweenPoundSourceLocationAndLeftParen = garbageBetweenPoundSourceLocationAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndArgs = garbageBetweenLeftParenAndArgs?.createGarbageNodes()
    self.args = args?.createPoundSourceLocationArgs()
    self.garbageBetweenArgsAndRightParen = garbageBetweenArgsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundSourceLocationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundSourceLocationSyntax`.
  func buildPoundSourceLocation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundSourceLocationSyntax {
    let result = SyntaxFactory.makePoundSourceLocation(
      garbageBeforePoundSourceLocation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundSourceLocation: poundSourceLocation,
      garbageBetweenPoundSourceLocationAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgs?.buildGarbageNodes(format: format, leadingTrivia: nil),
      args: args?.buildPoundSourceLocationArgs(format: format, leadingTrivia: nil),
      garbageBetweenArgsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundSourceLocation(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundSourceLocation`.
  public func createPoundSourceLocation() -> PoundSourceLocation {
    return self
  }

  /// `PoundSourceLocation` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `PoundSourceLocation` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct PoundSourceLocationArgs: SyntaxBuildable, ExpressibleAsPoundSourceLocationArgs {
  let garbageBeforeFileArgLabel: GarbageNodes?
  let fileArgLabel: TokenSyntax
  let garbageBetweenFileArgLabelAndFileArgColon: GarbageNodes?
  let fileArgColon: TokenSyntax
  let garbageBetweenFileArgColonAndFileName: GarbageNodes?
  let fileName: TokenSyntax
  let garbageBetweenFileNameAndComma: GarbageNodes?
  let comma: TokenSyntax
  let garbageBetweenCommaAndLineArgLabel: GarbageNodes?
  let lineArgLabel: TokenSyntax
  let garbageBetweenLineArgLabelAndLineArgColon: GarbageNodes?
  let lineArgColon: TokenSyntax
  let garbageBetweenLineArgColonAndLineNumber: GarbageNodes?
  let lineNumber: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundSourceLocationArgs` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeFileArgLabel: 
  ///   - fileArgLabel: 
  ///   - garbageBetweenFileArgLabelAndFileArgColon: 
  ///   - fileArgColon: 
  ///   - garbageBetweenFileArgColonAndFileName: 
  ///   - fileName: 
  ///   - garbageBetweenFileNameAndComma: 
  ///   - comma: 
  ///   - garbageBetweenCommaAndLineArgLabel: 
  ///   - lineArgLabel: 
  ///   - garbageBetweenLineArgLabelAndLineArgColon: 
  ///   - lineArgColon: 
  ///   - garbageBetweenLineArgColonAndLineNumber: 
  ///   - lineNumber: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeFileArgLabel: ExpressibleAsGarbageNodes? = nil,
    fileArgLabel: TokenSyntax,
    garbageBetweenFileArgLabelAndFileArgColon: ExpressibleAsGarbageNodes? = nil,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenFileArgColonAndFileName: ExpressibleAsGarbageNodes? = nil,
    fileName: TokenSyntax,
    garbageBetweenFileNameAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax = TokenSyntax.`comma`,
    garbageBetweenCommaAndLineArgLabel: ExpressibleAsGarbageNodes? = nil,
    lineArgLabel: TokenSyntax,
    garbageBetweenLineArgLabelAndLineArgColon: ExpressibleAsGarbageNodes? = nil,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenLineArgColonAndLineNumber: ExpressibleAsGarbageNodes? = nil,
    lineNumber: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeFileArgLabel = garbageBeforeFileArgLabel?.createGarbageNodes()
    self.fileArgLabel = fileArgLabel
    assert(fileArgLabel.text == "file")
    self.garbageBetweenFileArgLabelAndFileArgColon = garbageBetweenFileArgLabelAndFileArgColon?.createGarbageNodes()
    self.fileArgColon = fileArgColon
    assert(fileArgColon.text == ":")
    self.garbageBetweenFileArgColonAndFileName = garbageBetweenFileArgColonAndFileName?.createGarbageNodes()
    self.fileName = fileName
    self.garbageBetweenFileNameAndComma = garbageBetweenFileNameAndComma?.createGarbageNodes()
    self.comma = comma
    assert(comma.text == ",")
    self.garbageBetweenCommaAndLineArgLabel = garbageBetweenCommaAndLineArgLabel?.createGarbageNodes()
    self.lineArgLabel = lineArgLabel
    assert(lineArgLabel.text == "line")
    self.garbageBetweenLineArgLabelAndLineArgColon = garbageBetweenLineArgLabelAndLineArgColon?.createGarbageNodes()
    self.lineArgColon = lineArgColon
    assert(lineArgColon.text == ":")
    self.garbageBetweenLineArgColonAndLineNumber = garbageBetweenLineArgColonAndLineNumber?.createGarbageNodes()
    self.lineNumber = lineNumber
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeFileArgLabel: ExpressibleAsGarbageNodes? = nil,
    fileArgLabel: String,
    garbageBetweenFileArgLabelAndFileArgColon: ExpressibleAsGarbageNodes? = nil,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenFileArgColonAndFileName: ExpressibleAsGarbageNodes? = nil,
    fileName: String,
    garbageBetweenFileNameAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax = TokenSyntax.`comma`,
    garbageBetweenCommaAndLineArgLabel: ExpressibleAsGarbageNodes? = nil,
    lineArgLabel: String,
    garbageBetweenLineArgLabelAndLineArgColon: ExpressibleAsGarbageNodes? = nil,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenLineArgColonAndLineNumber: ExpressibleAsGarbageNodes? = nil,
    lineNumber: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeFileArgLabel: garbageBeforeFileArgLabel,
      fileArgLabel: TokenSyntax.identifier(fileArgLabel),
      garbageBetweenFileArgLabelAndFileArgColon: garbageBetweenFileArgLabelAndFileArgColon,
      fileArgColon: fileArgColon,
      garbageBetweenFileArgColonAndFileName: garbageBetweenFileArgColonAndFileName,
      fileName: TokenSyntax.stringLiteral(fileName),
      garbageBetweenFileNameAndComma: garbageBetweenFileNameAndComma,
      comma: comma,
      garbageBetweenCommaAndLineArgLabel: garbageBetweenCommaAndLineArgLabel,
      lineArgLabel: TokenSyntax.identifier(lineArgLabel),
      garbageBetweenLineArgLabelAndLineArgColon: garbageBetweenLineArgLabelAndLineArgColon,
      lineArgColon: lineArgColon,
      garbageBetweenLineArgColonAndLineNumber: garbageBetweenLineArgColonAndLineNumber,
      lineNumber: TokenSyntax.integerLiteral(lineNumber)
    )
  }

  /// Builds a `PoundSourceLocationArgsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundSourceLocationArgsSyntax`.
  func buildPoundSourceLocationArgs(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundSourceLocationArgsSyntax {
    let result = SyntaxFactory.makePoundSourceLocationArgs(
      garbageBeforeFileArgLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      fileArgLabel: fileArgLabel,
      garbageBetweenFileArgLabelAndFileArgColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      fileArgColon: fileArgColon,
      garbageBetweenFileArgColonAndFileName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      fileName: fileName,
      garbageBetweenFileNameAndComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      comma: comma,
      garbageBetweenCommaAndLineArgLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      lineArgLabel: lineArgLabel,
      garbageBetweenLineArgLabelAndLineArgColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      lineArgColon: lineArgColon,
      garbageBetweenLineArgColonAndLineNumber?.buildGarbageNodes(format: format, leadingTrivia: nil),
      lineNumber: lineNumber
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPoundSourceLocationArgs(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPoundSourceLocationArgs`.
  public func createPoundSourceLocationArgs() -> PoundSourceLocationArgs {
    return self
  }

  /// `PoundSourceLocationArgs` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DeclModifierDetail: SyntaxBuildable, ExpressibleAsDeclModifierDetail {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndDetail: GarbageNodes?
  let detail: TokenSyntax
  let garbageBetweenDetailAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclModifierDetail` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndDetail: 
  ///   - detail: 
  ///   - garbageBetweenDetailAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndDetail: ExpressibleAsGarbageNodes? = nil,
    detail: TokenSyntax,
    garbageBetweenDetailAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndDetail = garbageBetweenLeftParenAndDetail?.createGarbageNodes()
    self.detail = detail
    self.garbageBetweenDetailAndRightParen = garbageBetweenDetailAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndDetail: ExpressibleAsGarbageNodes? = nil,
    detail: String,
    garbageBetweenDetailAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndDetail: garbageBetweenLeftParenAndDetail,
      detail: TokenSyntax.identifier(detail),
      garbageBetweenDetailAndRightParen: garbageBetweenDetailAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `DeclModifierDetailSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclModifierDetailSyntax`.
  func buildDeclModifierDetail(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclModifierDetailSyntax {
    let result = SyntaxFactory.makeDeclModifierDetail(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndDetail?.buildGarbageNodes(format: format, leadingTrivia: nil),
      detail: detail,
      garbageBetweenDetailAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclModifierDetail(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDeclModifierDetail`.
  public func createDeclModifierDetail() -> DeclModifierDetail {
    return self
  }

  /// `DeclModifierDetail` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DeclModifier: SyntaxBuildable, ExpressibleAsDeclModifier {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndDetail: GarbageNodes?
  let detail: DeclModifierDetail?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclModifier` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndDetail: 
  ///   - detail: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndDetail: ExpressibleAsGarbageNodes? = nil,
    detail: ExpressibleAsDeclModifierDetail? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    assert(name.text == "class" || name.text == "convenience" || name.text == "dynamic" || name.text == "final" || name.text == "infix" || name.text == "lazy" || name.text == "optional" || name.text == "override" || name.text == "postfix" || name.text == "prefix" || name.text == "required" || name.text == "static" || name.text == "unowned" || name.text == "weak" || name.text == "private" || name.text == "fileprivate" || name.text == "internal" || name.text == "public" || name.text == "open" || name.text == "mutating" || name.text == "nonmutating" || name.text == "indirect" || name.text == "__consuming" || name.text == "actor" || name.text == "async" || name.text == "distributed" || name.text == "isolated" || name.text == "nonisolated" || name.text == "_const" || name.text == "_local")
    self.garbageBetweenNameAndDetail = garbageBetweenNameAndDetail?.createGarbageNodes()
    self.detail = detail?.createDeclModifierDetail()
  }


  /// Builds a `DeclModifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclModifierSyntax`.
  func buildDeclModifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclModifierSyntax {
    let result = SyntaxFactory.makeDeclModifier(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndDetail?.buildGarbageNodes(format: format, leadingTrivia: nil),
      detail: detail?.buildDeclModifierDetail(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclModifier(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDeclModifier`.
  public func createDeclModifier() -> DeclModifier {
    return self
  }

  /// `DeclModifier` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct InheritedType: SyntaxBuildable, ExpressibleAsInheritedType, HasTrailingComma {
  let garbageBeforeTypeName: GarbageNodes?
  let typeName: TypeBuildable
  let garbageBetweenTypeNameAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InheritedType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeTypeName: 
  ///   - typeName: 
  ///   - garbageBetweenTypeNameAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeTypeName: ExpressibleAsGarbageNodes? = nil,
    typeName: ExpressibleAsTypeBuildable,
    garbageBetweenTypeNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeTypeName = garbageBeforeTypeName?.createGarbageNodes()
    self.typeName = typeName.createTypeBuildable()
    self.garbageBetweenTypeNameAndTrailingComma = garbageBetweenTypeNameAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `InheritedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InheritedTypeSyntax`.
  func buildInheritedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InheritedTypeSyntax {
    let result = SyntaxFactory.makeInheritedType(
      garbageBeforeTypeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeName: typeName.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeNameAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildInheritedType(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsInheritedType`.
  public func createInheritedType() -> InheritedType {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeTypeName: garbageBeforeTypeName,
        typeName: typeName,
        garbageBetweenTypeNameAndTrailingComma: garbageBetweenTypeNameAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `InheritedType` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct TypeInheritanceClause: SyntaxBuildable, ExpressibleAsTypeInheritanceClause {
  let garbageBeforeColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndInheritedTypeCollection: GarbageNodes?
  let inheritedTypeCollection: InheritedTypeList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeInheritanceClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndInheritedTypeCollection: 
  ///   - inheritedTypeCollection: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndInheritedTypeCollection: ExpressibleAsGarbageNodes? = nil,
    inheritedTypeCollection: ExpressibleAsInheritedTypeList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeColon = garbageBeforeColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndInheritedTypeCollection = garbageBetweenColonAndInheritedTypeCollection?.createGarbageNodes()
    self.inheritedTypeCollection = inheritedTypeCollection.createInheritedTypeList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndInheritedTypeCollection: ExpressibleAsGarbageNodes? = nil,
    @InheritedTypeListBuilder inheritedTypeCollectionBuilder: () -> ExpressibleAsInheritedTypeList = { InheritedTypeList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeColon: garbageBeforeColon,
      colon: colon,
      garbageBetweenColonAndInheritedTypeCollection: garbageBetweenColonAndInheritedTypeCollection,
      inheritedTypeCollection: inheritedTypeCollectionBuilder()
    )
  }

  /// Builds a `TypeInheritanceClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeInheritanceClauseSyntax`.
  func buildTypeInheritanceClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeInheritanceClauseSyntax {
    let result = SyntaxFactory.makeTypeInheritanceClause(
      garbageBeforeColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndInheritedTypeCollection?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritedTypeCollection: inheritedTypeCollection.buildInheritedTypeList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeInheritanceClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTypeInheritanceClause`.
  public func createTypeInheritanceClause() -> TypeInheritanceClause {
    return self
  }

  /// `TypeInheritanceClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ClassDecl: DeclBuildable, ExpressibleAsClassDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndClassKeyword: GarbageNodes?
  let classKeyword: TokenSyntax
  let garbageBetweenClassKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClassDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndClassKeyword: 
  ///   - classKeyword: 
  ///   - garbageBetweenClassKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndClassKeyword: ExpressibleAsGarbageNodes? = nil,
    classKeyword: TokenSyntax = TokenSyntax.`class`,
    garbageBetweenClassKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndClassKeyword = garbageBetweenModifiersAndClassKeyword?.createGarbageNodes()
    self.classKeyword = classKeyword
    assert(classKeyword.text == "class")
    self.garbageBetweenClassKeywordAndIdentifier = garbageBetweenClassKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameterClause = garbageBetweenIdentifierAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndInheritanceClause = garbageBetweenGenericParameterClauseAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndClassKeyword: ExpressibleAsGarbageNodes? = nil,
    classKeyword: TokenSyntax = TokenSyntax.`class`,
    garbageBetweenClassKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndClassKeyword: garbageBetweenModifiersAndClassKeyword,
      classKeyword: classKeyword,
      garbageBetweenClassKeywordAndIdentifier: garbageBetweenClassKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericParameterClause: garbageBetweenIdentifierAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndInheritanceClause: garbageBetweenGenericParameterClauseAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `ClassDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClassDeclSyntax`.
  func buildClassDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClassDeclSyntax {
    let result = SyntaxFactory.makeClassDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndClassKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      classKeyword: classKeyword,
      garbageBetweenClassKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildClassDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsClassDecl`.
  public func createClassDecl() -> ClassDecl {
    return self
  }

  /// `ClassDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `ClassDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ActorDecl: DeclBuildable, ExpressibleAsActorDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndActorKeyword: GarbageNodes?
  let actorKeyword: TokenSyntax
  let garbageBetweenActorKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ActorDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndActorKeyword: 
  ///   - actorKeyword: 
  ///   - garbageBetweenActorKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndActorKeyword: ExpressibleAsGarbageNodes? = nil,
    actorKeyword: TokenSyntax,
    garbageBetweenActorKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndActorKeyword = garbageBetweenModifiersAndActorKeyword?.createGarbageNodes()
    self.actorKeyword = actorKeyword
    assert(actorKeyword.text == "actor")
    self.garbageBetweenActorKeywordAndIdentifier = garbageBetweenActorKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameterClause = garbageBetweenIdentifierAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndInheritanceClause = garbageBetweenGenericParameterClauseAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndActorKeyword: ExpressibleAsGarbageNodes? = nil,
    actorKeyword: String,
    garbageBetweenActorKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndActorKeyword: garbageBetweenModifiersAndActorKeyword,
      actorKeyword: TokenSyntax.contextualKeyword(actorKeyword),
      garbageBetweenActorKeywordAndIdentifier: garbageBetweenActorKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericParameterClause: garbageBetweenIdentifierAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndInheritanceClause: garbageBetweenGenericParameterClauseAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `ActorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ActorDeclSyntax`.
  func buildActorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ActorDeclSyntax {
    let result = SyntaxFactory.makeActorDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndActorKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      actorKeyword: actorKeyword,
      garbageBetweenActorKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildActorDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsActorDecl`.
  public func createActorDecl() -> ActorDecl {
    return self
  }

  /// `ActorDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `ActorDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct StructDecl: DeclBuildable, ExpressibleAsStructDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndStructKeyword: GarbageNodes?
  let structKeyword: TokenSyntax
  let garbageBetweenStructKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StructDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndStructKeyword: 
  ///   - structKeyword: 
  ///   - garbageBetweenStructKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndStructKeyword: ExpressibleAsGarbageNodes? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    garbageBetweenStructKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndStructKeyword = garbageBetweenModifiersAndStructKeyword?.createGarbageNodes()
    self.structKeyword = structKeyword
    assert(structKeyword.text == "struct")
    self.garbageBetweenStructKeywordAndIdentifier = garbageBetweenStructKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameterClause = garbageBetweenIdentifierAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndInheritanceClause = garbageBetweenGenericParameterClauseAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndStructKeyword: ExpressibleAsGarbageNodes? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    garbageBetweenStructKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndStructKeyword: garbageBetweenModifiersAndStructKeyword,
      structKeyword: structKeyword,
      garbageBetweenStructKeywordAndIdentifier: garbageBetweenStructKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericParameterClause: garbageBetweenIdentifierAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndInheritanceClause: garbageBetweenGenericParameterClauseAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `StructDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StructDeclSyntax`.
  func buildStructDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StructDeclSyntax {
    let result = SyntaxFactory.makeStructDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndStructKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      structKeyword: structKeyword,
      garbageBetweenStructKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildStructDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsStructDecl`.
  public func createStructDecl() -> StructDecl {
    return self
  }

  /// `StructDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `StructDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ProtocolDecl: DeclBuildable, ExpressibleAsProtocolDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndProtocolKeyword: GarbageNodes?
  let protocolKeyword: TokenSyntax
  let garbageBetweenProtocolKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: GarbageNodes?
  let primaryAssociatedTypeClause: PrimaryAssociatedTypeClause?
  let garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ProtocolDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndProtocolKeyword: 
  ///   - protocolKeyword: 
  ///   - garbageBetweenProtocolKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: 
  ///   - primaryAssociatedTypeClause: 
  ///   - garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndProtocolKeyword: ExpressibleAsGarbageNodes? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    garbageBetweenProtocolKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: ExpressibleAsGarbageNodes? = nil,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndProtocolKeyword = garbageBetweenModifiersAndProtocolKeyword?.createGarbageNodes()
    self.protocolKeyword = protocolKeyword
    assert(protocolKeyword.text == "protocol")
    self.garbageBetweenProtocolKeywordAndIdentifier = garbageBetweenProtocolKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndPrimaryAssociatedTypeClause = garbageBetweenIdentifierAndPrimaryAssociatedTypeClause?.createGarbageNodes()
    self.primaryAssociatedTypeClause = primaryAssociatedTypeClause?.createPrimaryAssociatedTypeClause()
    self.garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause = garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndProtocolKeyword: ExpressibleAsGarbageNodes? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    garbageBetweenProtocolKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: ExpressibleAsGarbageNodes? = nil,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndProtocolKeyword: garbageBetweenModifiersAndProtocolKeyword,
      protocolKeyword: protocolKeyword,
      garbageBetweenProtocolKeywordAndIdentifier: garbageBetweenProtocolKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: garbageBetweenIdentifierAndPrimaryAssociatedTypeClause,
      primaryAssociatedTypeClause: primaryAssociatedTypeClause,
      garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `ProtocolDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ProtocolDeclSyntax`.
  func buildProtocolDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ProtocolDeclSyntax {
    let result = SyntaxFactory.makeProtocolDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndProtocolKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      protocolKeyword: protocolKeyword,
      garbageBetweenProtocolKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndPrimaryAssociatedTypeClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      primaryAssociatedTypeClause: primaryAssociatedTypeClause?.buildPrimaryAssociatedTypeClause(format: format, leadingTrivia: nil),
      garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildProtocolDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsProtocolDecl`.
  public func createProtocolDecl() -> ProtocolDecl {
    return self
  }

  /// `ProtocolDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `ProtocolDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ExtensionDecl: DeclBuildable, ExpressibleAsExtensionDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndExtensionKeyword: GarbageNodes?
  let extensionKeyword: TokenSyntax
  let garbageBetweenExtensionKeywordAndExtendedType: GarbageNodes?
  let extendedType: TypeBuildable
  let garbageBetweenExtendedTypeAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExtensionDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndExtensionKeyword: 
  ///   - extensionKeyword: 
  ///   - garbageBetweenExtensionKeywordAndExtendedType: 
  ///   - extendedType: 
  ///   - garbageBetweenExtendedTypeAndInheritanceClause: 
  ///   - inheritanceClause: 
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndExtensionKeyword: ExpressibleAsGarbageNodes? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    garbageBetweenExtensionKeywordAndExtendedType: ExpressibleAsGarbageNodes? = nil,
    extendedType: ExpressibleAsTypeBuildable,
    garbageBetweenExtendedTypeAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndExtensionKeyword = garbageBetweenModifiersAndExtensionKeyword?.createGarbageNodes()
    self.extensionKeyword = extensionKeyword
    assert(extensionKeyword.text == "extension")
    self.garbageBetweenExtensionKeywordAndExtendedType = garbageBetweenExtensionKeywordAndExtendedType?.createGarbageNodes()
    self.extendedType = extendedType.createTypeBuildable()
    self.garbageBetweenExtendedTypeAndInheritanceClause = garbageBetweenExtendedTypeAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndExtensionKeyword: ExpressibleAsGarbageNodes? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    garbageBetweenExtensionKeywordAndExtendedType: ExpressibleAsGarbageNodes? = nil,
    extendedType: ExpressibleAsTypeBuildable,
    garbageBetweenExtendedTypeAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndExtensionKeyword: garbageBetweenModifiersAndExtensionKeyword,
      extensionKeyword: extensionKeyword,
      garbageBetweenExtensionKeywordAndExtendedType: garbageBetweenExtensionKeywordAndExtendedType,
      extendedType: extendedType,
      garbageBetweenExtendedTypeAndInheritanceClause: garbageBetweenExtendedTypeAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `ExtensionDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExtensionDeclSyntax`.
  func buildExtensionDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExtensionDeclSyntax {
    let result = SyntaxFactory.makeExtensionDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndExtensionKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      extensionKeyword: extensionKeyword,
      garbageBetweenExtensionKeywordAndExtendedType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      extendedType: extendedType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenExtendedTypeAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildExtensionDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsExtensionDecl`.
  public func createExtensionDecl() -> ExtensionDecl {
    return self
  }

  /// `ExtensionDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `ExtensionDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MemberDeclBlock: SyntaxBuildable, ExpressibleAsMemberDeclBlock {
  let garbageBeforeLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndMembers: GarbageNodes?
  let members: MemberDeclList
  let garbageBetweenMembersAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberDeclBlock` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndMembers: 
  ///   - members: 
  ///   - garbageBetweenMembersAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclList,
    garbageBetweenMembersAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftBrace = garbageBeforeLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndMembers = garbageBetweenLeftBraceAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclList()
    self.garbageBetweenMembersAndRightBrace = garbageBetweenMembersAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndMembers: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenMembersAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftBrace: garbageBeforeLeftBrace,
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndMembers: garbageBetweenLeftBraceAndMembers,
      members: membersBuilder(),
      garbageBetweenMembersAndRightBrace: garbageBetweenMembersAndRightBrace,
      rightBrace: rightBrace
    )
  }

  /// Builds a `MemberDeclBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberDeclBlockSyntax`.
  func buildMemberDeclBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberDeclBlockSyntax {
    let result = SyntaxFactory.makeMemberDeclBlock(
      garbageBeforeLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclList(format: format._indented(), leadingTrivia: nil),
      garbageBetweenMembersAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMemberDeclBlock(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsMemberDeclBlock`.
  public func createMemberDeclBlock() -> MemberDeclBlock {
    return self
  }

  /// `MemberDeclBlock` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A member declaration of a type consisting of a declaration and anoptional semicolon;
public struct MemberDeclListItem: SyntaxBuildable, ExpressibleAsMemberDeclListItem {
  let garbageBeforeDecl: GarbageNodes?
  let decl: DeclBuildable
  let garbageBetweenDeclAndSemicolon: GarbageNodes?
  let semicolon: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberDeclListItem` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDecl: 
  ///   - decl: The declaration of the type member.
  ///   - garbageBetweenDeclAndSemicolon: 
  ///   - semicolon: An optional trailing semicolon.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDecl: ExpressibleAsGarbageNodes? = nil,
    decl: ExpressibleAsDeclBuildable,
    garbageBetweenDeclAndSemicolon: ExpressibleAsGarbageNodes? = nil,
    semicolon: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDecl = garbageBeforeDecl?.createGarbageNodes()
    self.decl = decl.createDeclBuildable()
    self.garbageBetweenDeclAndSemicolon = garbageBetweenDeclAndSemicolon?.createGarbageNodes()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
  }


  /// Builds a `MemberDeclListItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberDeclListItemSyntax`.
  func buildMemberDeclListItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberDeclListItemSyntax {
    let result = SyntaxFactory.makeMemberDeclListItem(
      garbageBeforeDecl?.buildGarbageNodes(format: format, leadingTrivia: nil),
      decl: decl.buildDecl(format: format, leadingTrivia: nil),
      garbageBetweenDeclAndSemicolon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMemberDeclListItem(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsMemberDeclListItem`.
  public func createMemberDeclListItem() -> MemberDeclListItem {
    return self
  }

  /// `MemberDeclListItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SourceFile: SyntaxBuildable, ExpressibleAsSourceFile {
  let garbageBeforeStatements: GarbageNodes?
  let statements: CodeBlockItemList
  let garbageBetweenStatementsAndEOFToken: GarbageNodes?
  let eofToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SourceFile` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeStatements: 
  ///   - statements: 
  ///   - garbageBetweenStatementsAndEOFToken: 
  ///   - eofToken: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeStatements: ExpressibleAsGarbageNodes? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    garbageBetweenStatementsAndEOFToken: ExpressibleAsGarbageNodes? = nil,
    eofToken: TokenSyntax = TokenSyntax.eof
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeStatements = garbageBeforeStatements?.createGarbageNodes()
    self.statements = statements.createCodeBlockItemList()
    self.garbageBetweenStatementsAndEOFToken = garbageBetweenStatementsAndEOFToken?.createGarbageNodes()
    self.eofToken = eofToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeStatements: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenStatementsAndEOFToken: ExpressibleAsGarbageNodes? = nil,
    eofToken: TokenSyntax = TokenSyntax.eof,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeStatements: garbageBeforeStatements,
      statements: statementsBuilder(),
      garbageBetweenStatementsAndEOFToken: garbageBetweenStatementsAndEOFToken,
      eofToken: eofToken
    )
  }

  /// Builds a `SourceFileSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SourceFileSyntax`.
  func buildSourceFile(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SourceFileSyntax {
    let result = SyntaxFactory.makeSourceFile(
      garbageBeforeStatements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format, leadingTrivia: nil),
      garbageBetweenStatementsAndEOFToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      eofToken: eofToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSourceFile(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsSourceFile`.
  public func createSourceFile() -> SourceFile {
    return self
  }

  /// `SourceFile` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct InitializerClause: SyntaxBuildable, ExpressibleAsInitializerClause {
  let garbageBeforeEqual: GarbageNodes?
  let equal: TokenSyntax
  let garbageBetweenEqualAndValue: GarbageNodes?
  let value: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeEqual: 
  ///   - equal: 
  ///   - garbageBetweenEqualAndValue: 
  ///   - value: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeEqual: ExpressibleAsGarbageNodes? = nil,
    equal: TokenSyntax = TokenSyntax.`equal`,
    garbageBetweenEqualAndValue: ExpressibleAsGarbageNodes? = nil,
    value: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeEqual = garbageBeforeEqual?.createGarbageNodes()
    self.equal = equal
    assert(equal.text == "=")
    self.garbageBetweenEqualAndValue = garbageBetweenEqualAndValue?.createGarbageNodes()
    self.value = value.createExprBuildable()
  }


  /// Builds a `InitializerClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InitializerClauseSyntax`.
  func buildInitializerClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InitializerClauseSyntax {
    let result = SyntaxFactory.makeInitializerClause(
      garbageBeforeEqual?.buildGarbageNodes(format: format, leadingTrivia: nil),
      equal: equal,
      garbageBetweenEqualAndValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      value: value.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildInitializerClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsInitializerClause`.
  public func createInitializerClause() -> InitializerClause {
    return self
  }

  /// `InitializerClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct FunctionParameter: SyntaxBuildable, ExpressibleAsFunctionParameter, HasTrailingComma {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndFirstName: GarbageNodes?
  let firstName: TokenSyntax?
  let garbageBetweenFirstNameAndSecondName: GarbageNodes?
  let secondName: TokenSyntax?
  let garbageBetweenSecondNameAndColon: GarbageNodes?
  let colon: TokenSyntax?
  let garbageBetweenColonAndType: GarbageNodes?
  let type: TypeBuildable?
  let garbageBetweenTypeAndEllipsis: GarbageNodes?
  let ellipsis: TokenSyntax?
  let garbageBetweenEllipsisAndDefaultArgument: GarbageNodes?
  let defaultArgument: InitializerClause?
  let garbageBetweenDefaultArgumentAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionParameter` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndFirstName: 
  ///   - firstName: 
  ///   - garbageBetweenFirstNameAndSecondName: 
  ///   - secondName: 
  ///   - garbageBetweenSecondNameAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndType: 
  ///   - type: 
  ///   - garbageBetweenTypeAndEllipsis: 
  ///   - ellipsis: 
  ///   - garbageBetweenEllipsisAndDefaultArgument: 
  ///   - defaultArgument: 
  ///   - garbageBetweenDefaultArgumentAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndFirstName: ExpressibleAsGarbageNodes? = nil,
    firstName: TokenSyntax? = nil,
    garbageBetweenFirstNameAndSecondName: ExpressibleAsGarbageNodes? = nil,
    secondName: TokenSyntax? = nil,
    garbageBetweenSecondNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenTypeAndEllipsis: ExpressibleAsGarbageNodes? = nil,
    ellipsis: TokenSyntax? = nil,
    garbageBetweenEllipsisAndDefaultArgument: ExpressibleAsGarbageNodes? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    garbageBetweenDefaultArgumentAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndFirstName = garbageBetweenAttributesAndFirstName?.createGarbageNodes()
    self.firstName = firstName
    self.garbageBetweenFirstNameAndSecondName = garbageBetweenFirstNameAndSecondName?.createGarbageNodes()
    self.secondName = secondName
    self.garbageBetweenSecondNameAndColon = garbageBetweenSecondNameAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.garbageBetweenColonAndType = garbageBetweenColonAndType?.createGarbageNodes()
    self.type = type?.createTypeBuildable()
    self.garbageBetweenTypeAndEllipsis = garbageBetweenTypeAndEllipsis?.createGarbageNodes()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ellipsis!.text == "...")
    self.garbageBetweenEllipsisAndDefaultArgument = garbageBetweenEllipsisAndDefaultArgument?.createGarbageNodes()
    self.defaultArgument = defaultArgument?.createInitializerClause()
    self.garbageBetweenDefaultArgumentAndTrailingComma = garbageBetweenDefaultArgumentAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `FunctionParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionParameterSyntax`.
  func buildFunctionParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionParameterSyntax {
    let result = SyntaxFactory.makeFunctionParameter(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndFirstName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      firstName: firstName,
      garbageBetweenFirstNameAndSecondName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      secondName: secondName,
      garbageBetweenSecondNameAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type?.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeAndEllipsis?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ellipsis: ellipsis,
      garbageBetweenEllipsisAndDefaultArgument?.buildGarbageNodes(format: format, leadingTrivia: nil),
      defaultArgument: defaultArgument?.buildInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenDefaultArgumentAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionParameter(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionParameter`.
  public func createFunctionParameter() -> FunctionParameter {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeAttributes: garbageBeforeAttributes,
        attributes: attributes,
        garbageBetweenAttributesAndFirstName: garbageBetweenAttributesAndFirstName,
        firstName: firstName,
        garbageBetweenFirstNameAndSecondName: garbageBetweenFirstNameAndSecondName,
        secondName: secondName,
        garbageBetweenSecondNameAndColon: garbageBetweenSecondNameAndColon,
        colon: colon,
        garbageBetweenColonAndType: garbageBetweenColonAndType,
        type: type,
        garbageBetweenTypeAndEllipsis: garbageBetweenTypeAndEllipsis,
        ellipsis: ellipsis,
        garbageBetweenEllipsisAndDefaultArgument: garbageBetweenEllipsisAndDefaultArgument,
        defaultArgument: defaultArgument,
        garbageBetweenDefaultArgumentAndTrailingComma: garbageBetweenDefaultArgumentAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `FunctionParameter` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct FunctionDecl: DeclBuildable, ExpressibleAsFunctionDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndFuncKeyword: GarbageNodes?
  let funcKeyword: TokenSyntax
  let garbageBetweenFuncKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndSignature: GarbageNodes?
  let signature: FunctionSignature
  let garbageBetweenSignatureAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndBody: GarbageNodes?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndFuncKeyword: 
  ///   - funcKeyword: 
  ///   - garbageBetweenFuncKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndSignature: 
  ///   - signature: 
  ///   - garbageBetweenSignatureAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndFuncKeyword: ExpressibleAsGarbageNodes? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    garbageBetweenFuncKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsFunctionSignature,
    garbageBetweenSignatureAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndFuncKeyword = garbageBetweenModifiersAndFuncKeyword?.createGarbageNodes()
    self.funcKeyword = funcKeyword
    assert(funcKeyword.text == "func")
    self.garbageBetweenFuncKeywordAndIdentifier = garbageBetweenFuncKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameterClause = garbageBetweenIdentifierAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndSignature = garbageBetweenGenericParameterClauseAndSignature?.createGarbageNodes()
    self.signature = signature.createFunctionSignature()
    self.garbageBetweenSignatureAndGenericWhereClause = garbageBetweenSignatureAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndBody = garbageBetweenGenericWhereClauseAndBody?.createGarbageNodes()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndFuncKeyword: ExpressibleAsGarbageNodes? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    garbageBetweenFuncKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsFunctionSignature,
    garbageBetweenSignatureAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndFuncKeyword: garbageBetweenModifiersAndFuncKeyword,
      funcKeyword: funcKeyword,
      garbageBetweenFuncKeywordAndIdentifier: garbageBetweenFuncKeywordAndIdentifier,
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause: garbageBetweenIdentifierAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndSignature: garbageBetweenGenericParameterClauseAndSignature,
      signature: signature,
      garbageBetweenSignatureAndGenericWhereClause: garbageBetweenSignatureAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndBody: garbageBetweenGenericWhereClauseAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `FunctionDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionDeclSyntax`.
  func buildFunctionDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionDeclSyntax {
    let result = SyntaxFactory.makeFunctionDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndFuncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      funcKeyword: funcKeyword,
      garbageBetweenFuncKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndSignature?.buildGarbageNodes(format: format, leadingTrivia: nil),
      signature: signature.buildFunctionSignature(format: format, leadingTrivia: nil),
      garbageBetweenSignatureAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildFunctionDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionDecl`.
  public func createFunctionDecl() -> FunctionDecl {
    return self
  }

  /// `FunctionDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `FunctionDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct InitializerDecl: DeclBuildable, ExpressibleAsInitializerDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndInitKeyword: GarbageNodes?
  let initKeyword: TokenSyntax
  let garbageBetweenInitKeywordAndOptionalMark: GarbageNodes?
  let optionalMark: TokenSyntax?
  let garbageBetweenOptionalMarkAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndSignature: GarbageNodes?
  let signature: FunctionSignature
  let garbageBetweenSignatureAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndBody: GarbageNodes?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndInitKeyword: 
  ///   - initKeyword: 
  ///   - garbageBetweenInitKeywordAndOptionalMark: 
  ///   - optionalMark: 
  ///   - garbageBetweenOptionalMarkAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndSignature: 
  ///   - signature: 
  ///   - garbageBetweenSignatureAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndInitKeyword: ExpressibleAsGarbageNodes? = nil,
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    garbageBetweenInitKeywordAndOptionalMark: ExpressibleAsGarbageNodes? = nil,
    optionalMark: TokenSyntax? = nil,
    garbageBetweenOptionalMarkAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsFunctionSignature,
    garbageBetweenSignatureAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndInitKeyword = garbageBetweenModifiersAndInitKeyword?.createGarbageNodes()
    self.initKeyword = initKeyword
    assert(initKeyword.text == "init")
    self.garbageBetweenInitKeywordAndOptionalMark = garbageBetweenInitKeywordAndOptionalMark?.createGarbageNodes()
    self.optionalMark = optionalMark
    assert(optionalMark == nil || optionalMark!.text == "?" || optionalMark!.text == "?" || optionalMark!.text == "!")
    self.garbageBetweenOptionalMarkAndGenericParameterClause = garbageBetweenOptionalMarkAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndSignature = garbageBetweenGenericParameterClauseAndSignature?.createGarbageNodes()
    self.signature = signature.createFunctionSignature()
    self.garbageBetweenSignatureAndGenericWhereClause = garbageBetweenSignatureAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndBody = garbageBetweenGenericWhereClauseAndBody?.createGarbageNodes()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndInitKeyword: ExpressibleAsGarbageNodes? = nil,
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    garbageBetweenInitKeywordAndOptionalMark: ExpressibleAsGarbageNodes? = nil,
    optionalMark: TokenSyntax? = nil,
    garbageBetweenOptionalMarkAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndSignature: ExpressibleAsGarbageNodes? = nil,
    signature: ExpressibleAsFunctionSignature,
    garbageBetweenSignatureAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndInitKeyword: garbageBetweenModifiersAndInitKeyword,
      initKeyword: initKeyword,
      garbageBetweenInitKeywordAndOptionalMark: garbageBetweenInitKeywordAndOptionalMark,
      optionalMark: optionalMark,
      garbageBetweenOptionalMarkAndGenericParameterClause: garbageBetweenOptionalMarkAndGenericParameterClause,
      genericParameterClause: genericParameterClause,
      garbageBetweenGenericParameterClauseAndSignature: garbageBetweenGenericParameterClauseAndSignature,
      signature: signature,
      garbageBetweenSignatureAndGenericWhereClause: garbageBetweenSignatureAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndBody: garbageBetweenGenericWhereClauseAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `InitializerDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InitializerDeclSyntax`.
  func buildInitializerDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InitializerDeclSyntax {
    let result = SyntaxFactory.makeInitializerDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndInitKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initKeyword: initKeyword,
      garbageBetweenInitKeywordAndOptionalMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      optionalMark: optionalMark,
      garbageBetweenOptionalMarkAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndSignature?.buildGarbageNodes(format: format, leadingTrivia: nil),
      signature: signature.buildFunctionSignature(format: format, leadingTrivia: nil),
      garbageBetweenSignatureAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildInitializerDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsInitializerDecl`.
  public func createInitializerDecl() -> InitializerDecl {
    return self
  }

  /// `InitializerDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `InitializerDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DeinitializerDecl: DeclBuildable, ExpressibleAsDeinitializerDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndDeinitKeyword: GarbageNodes?
  let deinitKeyword: TokenSyntax
  let garbageBetweenDeinitKeywordAndBody: GarbageNodes?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeinitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndDeinitKeyword: 
  ///   - deinitKeyword: 
  ///   - garbageBetweenDeinitKeywordAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndDeinitKeyword: ExpressibleAsGarbageNodes? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    garbageBetweenDeinitKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndDeinitKeyword = garbageBetweenModifiersAndDeinitKeyword?.createGarbageNodes()
    self.deinitKeyword = deinitKeyword
    assert(deinitKeyword.text == "deinit")
    self.garbageBetweenDeinitKeywordAndBody = garbageBetweenDeinitKeywordAndBody?.createGarbageNodes()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndDeinitKeyword: ExpressibleAsGarbageNodes? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    garbageBetweenDeinitKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndDeinitKeyword: garbageBetweenModifiersAndDeinitKeyword,
      deinitKeyword: deinitKeyword,
      garbageBetweenDeinitKeywordAndBody: garbageBetweenDeinitKeywordAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `DeinitializerDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeinitializerDeclSyntax`.
  func buildDeinitializerDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeinitializerDeclSyntax {
    let result = SyntaxFactory.makeDeinitializerDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndDeinitKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      deinitKeyword: deinitKeyword,
      garbageBetweenDeinitKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildDeinitializerDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsDeinitializerDecl`.
  public func createDeinitializerDecl() -> DeinitializerDecl {
    return self
  }

  /// `DeinitializerDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `DeinitializerDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SubscriptDecl: DeclBuildable, ExpressibleAsSubscriptDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndSubscriptKeyword: GarbageNodes?
  let subscriptKeyword: TokenSyntax
  let garbageBetweenSubscriptKeywordAndGenericParameterClause: GarbageNodes?
  let genericParameterClause: GenericParameterClause?
  let garbageBetweenGenericParameterClauseAndIndices: GarbageNodes?
  let indices: ParameterClause
  let garbageBetweenIndicesAndResult: GarbageNodes?
  let result: ReturnClause
  let garbageBetweenResultAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndAccessor: GarbageNodes?
  let accessor: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SubscriptDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndSubscriptKeyword: 
  ///   - subscriptKeyword: 
  ///   - garbageBetweenSubscriptKeywordAndGenericParameterClause: 
  ///   - genericParameterClause: 
  ///   - garbageBetweenGenericParameterClauseAndIndices: 
  ///   - indices: 
  ///   - garbageBetweenIndicesAndResult: 
  ///   - result: 
  ///   - garbageBetweenResultAndGenericWhereClause: 
  ///   - genericWhereClause: 
  ///   - garbageBetweenGenericWhereClauseAndAccessor: 
  ///   - accessor: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndSubscriptKeyword: ExpressibleAsGarbageNodes? = nil,
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    garbageBetweenSubscriptKeywordAndGenericParameterClause: ExpressibleAsGarbageNodes? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParameterClauseAndIndices: ExpressibleAsGarbageNodes? = nil,
    indices: ExpressibleAsParameterClause,
    garbageBetweenIndicesAndResult: ExpressibleAsGarbageNodes? = nil,
    result: ExpressibleAsReturnClause,
    garbageBetweenResultAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndAccessor: ExpressibleAsGarbageNodes? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndSubscriptKeyword = garbageBetweenModifiersAndSubscriptKeyword?.createGarbageNodes()
    self.subscriptKeyword = subscriptKeyword
    assert(subscriptKeyword.text == "subscript")
    self.garbageBetweenSubscriptKeywordAndGenericParameterClause = garbageBetweenSubscriptKeywordAndGenericParameterClause?.createGarbageNodes()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.garbageBetweenGenericParameterClauseAndIndices = garbageBetweenGenericParameterClauseAndIndices?.createGarbageNodes()
    self.indices = indices.createParameterClause()
    self.garbageBetweenIndicesAndResult = garbageBetweenIndicesAndResult?.createGarbageNodes()
    self.result = result.createReturnClause()
    self.garbageBetweenResultAndGenericWhereClause = garbageBetweenResultAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndAccessor = garbageBetweenGenericWhereClauseAndAccessor?.createGarbageNodes()
    self.accessor = accessor?.createSyntaxBuildable()
  }


  /// Builds a `SubscriptDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SubscriptDeclSyntax`.
  func buildSubscriptDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SubscriptDeclSyntax {
    let result = SyntaxFactory.makeSubscriptDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndSubscriptKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      subscriptKeyword: subscriptKeyword,
      garbageBetweenSubscriptKeywordAndGenericParameterClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterClauseAndIndices?.buildGarbageNodes(format: format, leadingTrivia: nil),
      indices: indices.buildParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenIndicesAndResult?.buildGarbageNodes(format: format, leadingTrivia: nil),
      result: result.buildReturnClause(format: format, leadingTrivia: nil),
      garbageBetweenResultAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndAccessor?.buildGarbageNodes(format: format, leadingTrivia: nil),
      accessor: accessor?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildSubscriptDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsSubscriptDecl`.
  public func createSubscriptDecl() -> SubscriptDecl {
    return self
  }

  /// `SubscriptDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `SubscriptDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AccessLevelModifier: SyntaxBuildable, ExpressibleAsAccessLevelModifier {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndModifier: GarbageNodes?
  let modifier: DeclModifierDetail?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessLevelModifier` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndModifier: 
  ///   - modifier: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndModifier: ExpressibleAsGarbageNodes? = nil,
    modifier: ExpressibleAsDeclModifierDetail? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndModifier = garbageBetweenNameAndModifier?.createGarbageNodes()
    self.modifier = modifier?.createDeclModifierDetail()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndModifier: ExpressibleAsGarbageNodes? = nil,
    modifier: ExpressibleAsDeclModifierDetail? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndModifier: garbageBetweenNameAndModifier,
      modifier: modifier
    )
  }

  /// Builds a `AccessLevelModifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessLevelModifierSyntax`.
  func buildAccessLevelModifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessLevelModifierSyntax {
    let result = SyntaxFactory.makeAccessLevelModifier(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndModifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifier: modifier?.buildDeclModifierDetail(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessLevelModifier(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAccessLevelModifier`.
  public func createAccessLevelModifier() -> AccessLevelModifier {
    return self
  }

  /// `AccessLevelModifier` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct AccessPathComponent: SyntaxBuildable, ExpressibleAsAccessPathComponent {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndTrailingDot: GarbageNodes?
  let trailingDot: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessPathComponent` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndTrailingDot: 
  ///   - trailingDot: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndTrailingDot: ExpressibleAsGarbageNodes? = nil,
    trailingDot: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndTrailingDot = garbageBetweenNameAndTrailingDot?.createGarbageNodes()
    self.trailingDot = trailingDot
    assert(trailingDot == nil || trailingDot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndTrailingDot: ExpressibleAsGarbageNodes? = nil,
    trailingDot: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndTrailingDot: garbageBetweenNameAndTrailingDot,
      trailingDot: trailingDot
    )
  }

  /// Builds a `AccessPathComponentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessPathComponentSyntax`.
  func buildAccessPathComponent(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessPathComponentSyntax {
    let result = SyntaxFactory.makeAccessPathComponent(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndTrailingDot?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingDot: trailingDot
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessPathComponent(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAccessPathComponent`.
  public func createAccessPathComponent() -> AccessPathComponent {
    return self
  }

  /// `AccessPathComponent` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ImportDecl: DeclBuildable, ExpressibleAsImportDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndImportTok: GarbageNodes?
  let importTok: TokenSyntax
  let garbageBetweenImportTokAndImportKind: GarbageNodes?
  let importKind: TokenSyntax?
  let garbageBetweenImportKindAndPath: GarbageNodes?
  let path: AccessPath

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImportDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndImportTok: 
  ///   - importTok: 
  ///   - garbageBetweenImportTokAndImportKind: 
  ///   - importKind: 
  ///   - garbageBetweenImportKindAndPath: 
  ///   - path: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndImportTok: ExpressibleAsGarbageNodes? = nil,
    importTok: TokenSyntax = TokenSyntax.`import`,
    garbageBetweenImportTokAndImportKind: ExpressibleAsGarbageNodes? = nil,
    importKind: TokenSyntax? = nil,
    garbageBetweenImportKindAndPath: ExpressibleAsGarbageNodes? = nil,
    path: ExpressibleAsAccessPath
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndImportTok = garbageBetweenModifiersAndImportTok?.createGarbageNodes()
    self.importTok = importTok
    assert(importTok.text == "import")
    self.garbageBetweenImportTokAndImportKind = garbageBetweenImportTokAndImportKind?.createGarbageNodes()
    self.importKind = importKind
    assert(importKind == nil || importKind!.text == "typealias" || importKind!.text == "struct" || importKind!.text == "class" || importKind!.text == "enum" || importKind!.text == "protocol" || importKind!.text == "var" || importKind!.text == "let" || importKind!.text == "func")
    self.garbageBetweenImportKindAndPath = garbageBetweenImportKindAndPath?.createGarbageNodes()
    self.path = path.createAccessPath()
  }


  /// Builds a `ImportDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImportDeclSyntax`.
  func buildImportDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImportDeclSyntax {
    let result = SyntaxFactory.makeImportDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndImportTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      importTok: importTok,
      garbageBetweenImportTokAndImportKind?.buildGarbageNodes(format: format, leadingTrivia: nil),
      importKind: importKind,
      garbageBetweenImportKindAndPath?.buildGarbageNodes(format: format, leadingTrivia: nil),
      path: path.buildAccessPath(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildImportDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsImportDecl`.
  public func createImportDecl() -> ImportDecl {
    return self
  }

  /// `ImportDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `ImportDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AccessorParameter: SyntaxBuildable, ExpressibleAsAccessorParameter {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorParameter` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndName = garbageBetweenLeftParenAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndRightParen = garbageBetweenNameAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndName: garbageBetweenLeftParenAndName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndRightParen: garbageBetweenNameAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `AccessorParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorParameterSyntax`.
  func buildAccessorParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorParameterSyntax {
    let result = SyntaxFactory.makeAccessorParameter(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessorParameter(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAccessorParameter`.
  public func createAccessorParameter() -> AccessorParameter {
    return self
  }

  /// `AccessorParameter` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct AccessorDecl: DeclBuildable, ExpressibleAsAccessorDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifier: GarbageNodes?
  let modifier: DeclModifier?
  let garbageBetweenModifierAndAccessorKind: GarbageNodes?
  let accessorKind: TokenSyntax
  let garbageBetweenAccessorKindAndParameter: GarbageNodes?
  let parameter: AccessorParameter?
  let garbageBetweenParameterAndAsyncKeyword: GarbageNodes?
  let asyncKeyword: TokenSyntax?
  let garbageBetweenAsyncKeywordAndThrowsKeyword: GarbageNodes?
  let throwsKeyword: TokenSyntax?
  let garbageBetweenThrowsKeywordAndBody: GarbageNodes?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifier: 
  ///   - modifier: 
  ///   - garbageBetweenModifierAndAccessorKind: 
  ///   - accessorKind: 
  ///   - garbageBetweenAccessorKindAndParameter: 
  ///   - parameter: 
  ///   - garbageBetweenParameterAndAsyncKeyword: 
  ///   - asyncKeyword: 
  ///   - garbageBetweenAsyncKeywordAndThrowsKeyword: 
  ///   - throwsKeyword: 
  ///   - garbageBetweenThrowsKeywordAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifier: ExpressibleAsGarbageNodes? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    garbageBetweenModifierAndAccessorKind: ExpressibleAsGarbageNodes? = nil,
    accessorKind: TokenSyntax,
    garbageBetweenAccessorKindAndParameter: ExpressibleAsGarbageNodes? = nil,
    parameter: ExpressibleAsAccessorParameter? = nil,
    garbageBetweenParameterAndAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: TokenSyntax? = nil,
    garbageBetweenAsyncKeywordAndThrowsKeyword: ExpressibleAsGarbageNodes? = nil,
    throwsKeyword: TokenSyntax? = nil,
    garbageBetweenThrowsKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifier = garbageBetweenAttributesAndModifier?.createGarbageNodes()
    self.modifier = modifier?.createDeclModifier()
    self.garbageBetweenModifierAndAccessorKind = garbageBetweenModifierAndAccessorKind?.createGarbageNodes()
    self.accessorKind = accessorKind
    assert(accessorKind.text == "get" || accessorKind.text == "set" || accessorKind.text == "didSet" || accessorKind.text == "willSet" || accessorKind.text == "unsafeAddress" || accessorKind.text == "addressWithOwner" || accessorKind.text == "addressWithNativeOwner" || accessorKind.text == "unsafeMutableAddress" || accessorKind.text == "mutableAddressWithOwner" || accessorKind.text == "mutableAddressWithNativeOwner" || accessorKind.text == "_read" || accessorKind.text == "_modify")
    self.garbageBetweenAccessorKindAndParameter = garbageBetweenAccessorKindAndParameter?.createGarbageNodes()
    self.parameter = parameter?.createAccessorParameter()
    self.garbageBetweenParameterAndAsyncKeyword = garbageBetweenParameterAndAsyncKeyword?.createGarbageNodes()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.garbageBetweenAsyncKeywordAndThrowsKeyword = garbageBetweenAsyncKeywordAndThrowsKeyword?.createGarbageNodes()
    self.throwsKeyword = throwsKeyword
    assert(throwsKeyword == nil || throwsKeyword!.text == "throws" || throwsKeyword!.text == "rethrows")
    self.garbageBetweenThrowsKeywordAndBody = garbageBetweenThrowsKeywordAndBody?.createGarbageNodes()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifier: ExpressibleAsGarbageNodes? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    garbageBetweenModifierAndAccessorKind: ExpressibleAsGarbageNodes? = nil,
    accessorKind: TokenSyntax,
    garbageBetweenAccessorKindAndParameter: ExpressibleAsGarbageNodes? = nil,
    parameter: ExpressibleAsAccessorParameter? = nil,
    garbageBetweenParameterAndAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: String?,
    garbageBetweenAsyncKeywordAndThrowsKeyword: ExpressibleAsGarbageNodes? = nil,
    throwsKeyword: TokenSyntax? = nil,
    garbageBetweenThrowsKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifier: garbageBetweenAttributesAndModifier,
      modifier: modifier,
      garbageBetweenModifierAndAccessorKind: garbageBetweenModifierAndAccessorKind,
      accessorKind: accessorKind,
      garbageBetweenAccessorKindAndParameter: garbageBetweenAccessorKindAndParameter,
      parameter: parameter,
      garbageBetweenParameterAndAsyncKeyword: garbageBetweenParameterAndAsyncKeyword,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      garbageBetweenAsyncKeywordAndThrowsKeyword: garbageBetweenAsyncKeywordAndThrowsKeyword,
      throwsKeyword: throwsKeyword,
      garbageBetweenThrowsKeywordAndBody: garbageBetweenThrowsKeywordAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `AccessorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorDeclSyntax`.
  func buildAccessorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorDeclSyntax {
    let result = SyntaxFactory.makeAccessorDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifier: modifier?.buildDeclModifier(format: format, leadingTrivia: nil),
      garbageBetweenModifierAndAccessorKind?.buildGarbageNodes(format: format, leadingTrivia: nil),
      accessorKind: accessorKind,
      garbageBetweenAccessorKindAndParameter?.buildGarbageNodes(format: format, leadingTrivia: nil),
      parameter: parameter?.buildAccessorParameter(format: format, leadingTrivia: nil),
      garbageBetweenParameterAndAsyncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      garbageBetweenAsyncKeywordAndThrowsKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwsKeyword: throwsKeyword,
      garbageBetweenThrowsKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildAccessorDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsAccessorDecl`.
  public func createAccessorDecl() -> AccessorDecl {
    return self
  }

  /// `AccessorDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `AccessorDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AccessorBlock: SyntaxBuildable, ExpressibleAsAccessorBlock {
  let garbageBeforeLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndAccessors: GarbageNodes?
  let accessors: AccessorList
  let garbageBetweenAccessorsAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorBlock` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndAccessors: 
  ///   - accessors: 
  ///   - garbageBetweenAccessorsAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndAccessors: ExpressibleAsGarbageNodes? = nil,
    accessors: ExpressibleAsAccessorList,
    garbageBetweenAccessorsAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftBrace = garbageBeforeLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndAccessors = garbageBetweenLeftBraceAndAccessors?.createGarbageNodes()
    self.accessors = accessors.createAccessorList()
    self.garbageBetweenAccessorsAndRightBrace = garbageBetweenAccessorsAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }


  /// Builds a `AccessorBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorBlockSyntax`.
  func buildAccessorBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorBlockSyntax {
    let result = SyntaxFactory.makeAccessorBlock(
      garbageBeforeLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndAccessors?.buildGarbageNodes(format: format, leadingTrivia: nil),
      accessors: accessors.buildAccessorList(format: format, leadingTrivia: nil),
      garbageBetweenAccessorsAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessorBlock(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAccessorBlock`.
  public func createAccessorBlock() -> AccessorBlock {
    return self
  }

  /// `AccessorBlock` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PatternBinding: SyntaxBuildable, ExpressibleAsPatternBinding, HasTrailingComma {
  let garbageBeforePattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndTypeAnnotation: GarbageNodes?
  let typeAnnotation: TypeAnnotation?
  let garbageBetweenTypeAnnotationAndInitializer: GarbageNodes?
  let initializer: InitializerClause?
  let garbageBetweenInitializerAndAccessor: GarbageNodes?
  let accessor: SyntaxBuildable?
  let garbageBetweenAccessorAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PatternBinding` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndTypeAnnotation: 
  ///   - typeAnnotation: 
  ///   - garbageBetweenTypeAnnotationAndInitializer: 
  ///   - initializer: 
  ///   - garbageBetweenInitializerAndAccessor: 
  ///   - accessor: 
  ///   - garbageBetweenAccessorAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    garbageBetweenTypeAnnotationAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    garbageBetweenInitializerAndAccessor: ExpressibleAsGarbageNodes? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
    garbageBetweenAccessorAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePattern = garbageBeforePattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndTypeAnnotation = garbageBetweenPatternAndTypeAnnotation?.createGarbageNodes()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.garbageBetweenTypeAnnotationAndInitializer = garbageBetweenTypeAnnotationAndInitializer?.createGarbageNodes()
    self.initializer = initializer?.createInitializerClause()
    self.garbageBetweenInitializerAndAccessor = garbageBetweenInitializerAndAccessor?.createGarbageNodes()
    self.accessor = accessor?.createSyntaxBuildable()
    self.garbageBetweenAccessorAndTrailingComma = garbageBetweenAccessorAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `PatternBindingSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PatternBindingSyntax`.
  func buildPatternBinding(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternBindingSyntax {
    let result = SyntaxFactory.makePatternBinding(
      garbageBeforePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndTypeAnnotation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      garbageBetweenTypeAnnotationAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenInitializerAndAccessor?.buildGarbageNodes(format: format, leadingTrivia: nil),
      accessor: accessor?.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenAccessorAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPatternBinding(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPatternBinding`.
  public func createPatternBinding() -> PatternBinding {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforePattern: garbageBeforePattern,
        pattern: pattern,
        garbageBetweenPatternAndTypeAnnotation: garbageBetweenPatternAndTypeAnnotation,
        typeAnnotation: typeAnnotation,
        garbageBetweenTypeAnnotationAndInitializer: garbageBetweenTypeAnnotationAndInitializer,
        initializer: initializer,
        garbageBetweenInitializerAndAccessor: garbageBetweenInitializerAndAccessor,
        accessor: accessor,
        garbageBetweenAccessorAndTrailingComma: garbageBetweenAccessorAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `PatternBinding` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct VariableDecl: DeclBuildable, ExpressibleAsVariableDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndLetOrVarKeyword: GarbageNodes?
  let letOrVarKeyword: TokenSyntax
  let garbageBetweenLetOrVarKeywordAndBindings: GarbageNodes?
  let bindings: PatternBindingList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `VariableDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: 
  ///   - garbageBetweenModifiersAndLetOrVarKeyword: 
  ///   - letOrVarKeyword: 
  ///   - garbageBetweenLetOrVarKeywordAndBindings: 
  ///   - bindings: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndLetOrVarKeyword: ExpressibleAsGarbageNodes? = nil,
    letOrVarKeyword: TokenSyntax,
    garbageBetweenLetOrVarKeywordAndBindings: ExpressibleAsGarbageNodes? = nil,
    bindings: ExpressibleAsPatternBindingList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndLetOrVarKeyword = garbageBetweenModifiersAndLetOrVarKeyword?.createGarbageNodes()
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.garbageBetweenLetOrVarKeywordAndBindings = garbageBetweenLetOrVarKeywordAndBindings?.createGarbageNodes()
    self.bindings = bindings.createPatternBindingList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndLetOrVarKeyword: ExpressibleAsGarbageNodes? = nil,
    letOrVarKeyword: TokenSyntax,
    garbageBetweenLetOrVarKeywordAndBindings: ExpressibleAsGarbageNodes? = nil,
    @PatternBindingListBuilder bindingsBuilder: () -> ExpressibleAsPatternBindingList = { PatternBindingList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndLetOrVarKeyword: garbageBetweenModifiersAndLetOrVarKeyword,
      letOrVarKeyword: letOrVarKeyword,
      garbageBetweenLetOrVarKeywordAndBindings: garbageBetweenLetOrVarKeywordAndBindings,
      bindings: bindingsBuilder()
    )
  }

  /// Builds a `VariableDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `VariableDeclSyntax`.
  func buildVariableDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> VariableDeclSyntax {
    let result = SyntaxFactory.makeVariableDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndLetOrVarKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      letOrVarKeyword: letOrVarKeyword,
      garbageBetweenLetOrVarKeywordAndBindings?.buildGarbageNodes(format: format, leadingTrivia: nil),
      bindings: bindings.buildPatternBindingList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildVariableDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsVariableDecl`.
  public func createVariableDecl() -> VariableDecl {
    return self
  }

  /// `VariableDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `VariableDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// An element of an enum case, containing the name of the case and,optionally, either associated values or an assignment to a raw value.
public struct EnumCaseElement: SyntaxBuildable, ExpressibleAsEnumCaseElement, HasTrailingComma {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndAssociatedValue: GarbageNodes?
  let associatedValue: ParameterClause?
  let garbageBetweenAssociatedValueAndRawValue: GarbageNodes?
  let rawValue: InitializerClause?
  let garbageBetweenRawValueAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCaseElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: The name of this case.
  ///   - garbageBetweenIdentifierAndAssociatedValue: 
  ///   - associatedValue: The set of associated values of the case.
  ///   - garbageBetweenAssociatedValueAndRawValue: 
  ///   - rawValue: The raw value of this enum element, if present.
  ///   - garbageBetweenRawValueAndTrailingComma: 
  ///   - trailingComma: The trailing comma of this element, if the case hasmultiple elements.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndAssociatedValue: ExpressibleAsGarbageNodes? = nil,
    associatedValue: ExpressibleAsParameterClause? = nil,
    garbageBetweenAssociatedValueAndRawValue: ExpressibleAsGarbageNodes? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    garbageBetweenRawValueAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndAssociatedValue = garbageBetweenIdentifierAndAssociatedValue?.createGarbageNodes()
    self.associatedValue = associatedValue?.createParameterClause()
    self.garbageBetweenAssociatedValueAndRawValue = garbageBetweenAssociatedValueAndRawValue?.createGarbageNodes()
    self.rawValue = rawValue?.createInitializerClause()
    self.garbageBetweenRawValueAndTrailingComma = garbageBetweenRawValueAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndAssociatedValue: ExpressibleAsGarbageNodes? = nil,
    associatedValue: ExpressibleAsParameterClause? = nil,
    garbageBetweenAssociatedValueAndRawValue: ExpressibleAsGarbageNodes? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    garbageBetweenRawValueAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeIdentifier: garbageBeforeIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndAssociatedValue: garbageBetweenIdentifierAndAssociatedValue,
      associatedValue: associatedValue,
      garbageBetweenAssociatedValueAndRawValue: garbageBetweenAssociatedValueAndRawValue,
      rawValue: rawValue,
      garbageBetweenRawValueAndTrailingComma: garbageBetweenRawValueAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `EnumCaseElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCaseElementSyntax`.
  func buildEnumCaseElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCaseElementSyntax {
    let result = SyntaxFactory.makeEnumCaseElement(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndAssociatedValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      associatedValue: associatedValue?.buildParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenAssociatedValueAndRawValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rawValue: rawValue?.buildInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenRawValueAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildEnumCaseElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsEnumCaseElement`.
  public func createEnumCaseElement() -> EnumCaseElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeIdentifier: garbageBeforeIdentifier,
        identifier: identifier,
        garbageBetweenIdentifierAndAssociatedValue: garbageBetweenIdentifierAndAssociatedValue,
        associatedValue: associatedValue,
        garbageBetweenAssociatedValueAndRawValue: garbageBetweenAssociatedValueAndRawValue,
        rawValue: rawValue,
        garbageBetweenRawValueAndTrailingComma: garbageBetweenRawValueAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `EnumCaseElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A `case` declaration of a Swift `enum`. It can have 1 or more`EnumCaseElement`s inside, each declaring a different case of theenum.
public struct EnumCaseDecl: DeclBuildable, ExpressibleAsEnumCaseDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndCaseKeyword: GarbageNodes?
  let caseKeyword: TokenSyntax
  let garbageBetweenCaseKeywordAndElements: GarbageNodes?
  let elements: EnumCaseElementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCaseDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: The attributes applied to the case declaration.
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: The declaration modifiers applied to the case declaration.
  ///   - garbageBetweenModifiersAndCaseKeyword: 
  ///   - caseKeyword: The `case` keyword for this case.
  ///   - garbageBetweenCaseKeywordAndElements: 
  ///   - elements: The elements this case declares.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    garbageBetweenCaseKeywordAndElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsEnumCaseElementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndCaseKeyword = garbageBetweenModifiersAndCaseKeyword?.createGarbageNodes()
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.garbageBetweenCaseKeywordAndElements = garbageBetweenCaseKeywordAndElements?.createGarbageNodes()
    self.elements = elements.createEnumCaseElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    garbageBetweenCaseKeywordAndElements: ExpressibleAsGarbageNodes? = nil,
    @EnumCaseElementListBuilder elementsBuilder: () -> ExpressibleAsEnumCaseElementList = { EnumCaseElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndCaseKeyword: garbageBetweenModifiersAndCaseKeyword,
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndElements: garbageBetweenCaseKeywordAndElements,
      elements: elementsBuilder()
    )
  }

  /// Builds a `EnumCaseDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCaseDeclSyntax`.
  func buildEnumCaseDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCaseDeclSyntax {
    let result = SyntaxFactory.makeEnumCaseDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndCaseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildEnumCaseElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildEnumCaseDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsEnumCaseDecl`.
  public func createEnumCaseDecl() -> EnumCaseDecl {
    return self
  }

  /// `EnumCaseDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `EnumCaseDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// A Swift `enum` declaration.
public struct EnumDecl: DeclBuildable, ExpressibleAsEnumDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndEnumKeyword: GarbageNodes?
  let enumKeyword: TokenSyntax
  let garbageBetweenEnumKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndGenericParameters: GarbageNodes?
  let genericParameters: GenericParameterClause?
  let garbageBetweenGenericParametersAndInheritanceClause: GarbageNodes?
  let inheritanceClause: TypeInheritanceClause?
  let garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodes?
  let genericWhereClause: GenericWhereClause?
  let garbageBetweenGenericWhereClauseAndMembers: GarbageNodes?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: The attributes applied to the enum declaration.
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: The declaration modifiers applied to the enum declaration.
  ///   - garbageBetweenModifiersAndEnumKeyword: 
  ///   - enumKeyword: The `enum` keyword for this declaration.
  ///   - garbageBetweenEnumKeywordAndIdentifier: 
  ///   - identifier: The name of this enum.
  ///   - garbageBetweenIdentifierAndGenericParameters: 
  ///   - genericParameters: The generic parameters, if any, for this enum.
  ///   - garbageBetweenGenericParametersAndInheritanceClause: 
  ///   - inheritanceClause: The inheritance clause describing conformances or rawvalues for this enum.
  ///   - garbageBetweenInheritanceClauseAndGenericWhereClause: 
  ///   - genericWhereClause: The `where` clause that applies to the generic parameters ofthis enum.
  ///   - garbageBetweenGenericWhereClauseAndMembers: 
  ///   - members: The cases and other members of this enum.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndEnumKeyword: ExpressibleAsGarbageNodes? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    garbageBetweenEnumKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndGenericParameters: ExpressibleAsGarbageNodes? = nil,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParametersAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndEnumKeyword = garbageBetweenModifiersAndEnumKeyword?.createGarbageNodes()
    self.enumKeyword = enumKeyword
    assert(enumKeyword.text == "enum")
    self.garbageBetweenEnumKeywordAndIdentifier = garbageBetweenEnumKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndGenericParameters = garbageBetweenIdentifierAndGenericParameters?.createGarbageNodes()
    self.genericParameters = genericParameters?.createGenericParameterClause()
    self.garbageBetweenGenericParametersAndInheritanceClause = garbageBetweenGenericParametersAndInheritanceClause?.createGarbageNodes()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.garbageBetweenInheritanceClauseAndGenericWhereClause = garbageBetweenInheritanceClauseAndGenericWhereClause?.createGarbageNodes()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.garbageBetweenGenericWhereClauseAndMembers = garbageBetweenGenericWhereClauseAndMembers?.createGarbageNodes()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndEnumKeyword: ExpressibleAsGarbageNodes? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    garbageBetweenEnumKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndGenericParameters: ExpressibleAsGarbageNodes? = nil,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    garbageBetweenGenericParametersAndInheritanceClause: ExpressibleAsGarbageNodes? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    garbageBetweenInheritanceClauseAndGenericWhereClause: ExpressibleAsGarbageNodes? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    garbageBetweenGenericWhereClauseAndMembers: ExpressibleAsGarbageNodes? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndEnumKeyword: garbageBetweenModifiersAndEnumKeyword,
      enumKeyword: enumKeyword,
      garbageBetweenEnumKeywordAndIdentifier: garbageBetweenEnumKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndGenericParameters: garbageBetweenIdentifierAndGenericParameters,
      genericParameters: genericParameters,
      garbageBetweenGenericParametersAndInheritanceClause: garbageBetweenGenericParametersAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      garbageBetweenInheritanceClauseAndGenericWhereClause: garbageBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      garbageBetweenGenericWhereClauseAndMembers: garbageBetweenGenericWhereClauseAndMembers,
      members: membersBuilder()
    )
  }

  /// Builds a `EnumDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumDeclSyntax`.
  func buildEnumDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumDeclSyntax {
    let result = SyntaxFactory.makeEnumDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndEnumKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      enumKeyword: enumKeyword,
      garbageBetweenEnumKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndGenericParameters?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameters: genericParameters?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericParametersAndInheritanceClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      garbageBetweenInheritanceClauseAndGenericWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenGenericWhereClauseAndMembers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildEnumDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsEnumDecl`.
  public func createEnumDecl() -> EnumDecl {
    return self
  }

  /// `EnumDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `EnumDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// A Swift `operator` declaration.
public struct OperatorDecl: DeclBuildable, ExpressibleAsOperatorDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndOperatorKeyword: GarbageNodes?
  let operatorKeyword: TokenSyntax
  let garbageBetweenOperatorKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: GarbageNodes?
  let operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OperatorDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: The attributes applied to the 'operator' declaration.
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: The declaration modifiers applied to the 'operator'declaration.
  ///   - garbageBetweenModifiersAndOperatorKeyword: 
  ///   - operatorKeyword: 
  ///   - garbageBetweenOperatorKeywordAndIdentifier: 
  ///   - identifier: 
  ///   - garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: 
  ///   - operatorPrecedenceAndTypes: Optionally specify a precedence group and designated types.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndOperatorKeyword: ExpressibleAsGarbageNodes? = nil,
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    garbageBetweenOperatorKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: ExpressibleAsGarbageNodes? = nil,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndOperatorKeyword = garbageBetweenModifiersAndOperatorKeyword?.createGarbageNodes()
    self.operatorKeyword = operatorKeyword
    assert(operatorKeyword.text == "operator")
    self.garbageBetweenOperatorKeywordAndIdentifier = garbageBetweenOperatorKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndOperatorPrecedenceAndTypes = garbageBetweenIdentifierAndOperatorPrecedenceAndTypes?.createGarbageNodes()
    self.operatorPrecedenceAndTypes = operatorPrecedenceAndTypes?.createOperatorPrecedenceAndTypes()
  }


  /// Builds a `OperatorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OperatorDeclSyntax`.
  func buildOperatorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OperatorDeclSyntax {
    let result = SyntaxFactory.makeOperatorDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndOperatorKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorKeyword: operatorKeyword,
      garbageBetweenOperatorKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndOperatorPrecedenceAndTypes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes?.buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildOperatorDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsOperatorDecl`.
  public func createOperatorDecl() -> OperatorDecl {
    return self
  }

  /// `OperatorDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `OperatorDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.
public struct OperatorPrecedenceAndTypes: SyntaxBuildable, ExpressibleAsOperatorPrecedenceAndTypes {
  let garbageBeforeColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: GarbageNodes?
  let precedenceGroupAndDesignatedTypes: IdentifierList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OperatorPrecedenceAndTypes` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: 
  ///   - precedenceGroupAndDesignatedTypes: The precedence group and designated types for this operator
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: ExpressibleAsGarbageNodes? = nil,
    precedenceGroupAndDesignatedTypes: ExpressibleAsIdentifierList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeColon = garbageBeforeColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes = garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes?.createGarbageNodes()
    self.precedenceGroupAndDesignatedTypes = precedenceGroupAndDesignatedTypes.createIdentifierList()
  }


  /// Builds a `OperatorPrecedenceAndTypesSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OperatorPrecedenceAndTypesSyntax`.
  func buildOperatorPrecedenceAndTypes(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let result = SyntaxFactory.makeOperatorPrecedenceAndTypes(
      garbageBeforeColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypes.buildIdentifierList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsOperatorPrecedenceAndTypes`.
  public func createOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypes {
    return self
  }

  /// `OperatorPrecedenceAndTypes` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDecl: DeclBuildable, ExpressibleAsPrecedenceGroupDecl {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndModifiers: GarbageNodes?
  let modifiers: ModifierList?
  let garbageBetweenModifiersAndPrecedencegroupKeyword: GarbageNodes?
  let precedencegroupKeyword: TokenSyntax
  let garbageBetweenPrecedencegroupKeywordAndIdentifier: GarbageNodes?
  let identifier: TokenSyntax
  let garbageBetweenIdentifierAndLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndGroupAttributes: GarbageNodes?
  let groupAttributes: PrecedenceGroupAttributeList
  let garbageBetweenGroupAttributesAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupDecl` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: The attributes applied to the 'precedencegroup' declaration.
  ///   - garbageBetweenAttributesAndModifiers: 
  ///   - modifiers: The declaration modifiers applied to the 'precedencegroup'declaration.
  ///   - garbageBetweenModifiersAndPrecedencegroupKeyword: 
  ///   - precedencegroupKeyword: 
  ///   - garbageBetweenPrecedencegroupKeywordAndIdentifier: 
  ///   - identifier: The name of this precedence group.
  ///   - garbageBetweenIdentifierAndLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndGroupAttributes: 
  ///   - groupAttributes: The characteristics of this precedence group.
  ///   - garbageBetweenGroupAttributesAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndPrecedencegroupKeyword: ExpressibleAsGarbageNodes? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    garbageBetweenPrecedencegroupKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax,
    garbageBetweenIdentifierAndLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndGroupAttributes: ExpressibleAsGarbageNodes? = nil,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    garbageBetweenGroupAttributesAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndModifiers = garbageBetweenAttributesAndModifiers?.createGarbageNodes()
    self.modifiers = modifiers?.createModifierList()
    self.garbageBetweenModifiersAndPrecedencegroupKeyword = garbageBetweenModifiersAndPrecedencegroupKeyword?.createGarbageNodes()
    self.precedencegroupKeyword = precedencegroupKeyword
    assert(precedencegroupKeyword.text == "precedencegroup")
    self.garbageBetweenPrecedencegroupKeywordAndIdentifier = garbageBetweenPrecedencegroupKeywordAndIdentifier?.createGarbageNodes()
    self.identifier = identifier
    self.garbageBetweenIdentifierAndLeftBrace = garbageBetweenIdentifierAndLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndGroupAttributes = garbageBetweenLeftBraceAndGroupAttributes?.createGarbageNodes()
    self.groupAttributes = groupAttributes.createPrecedenceGroupAttributeList()
    self.garbageBetweenGroupAttributesAndRightBrace = garbageBetweenGroupAttributesAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndModifiers: ExpressibleAsGarbageNodes? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    garbageBetweenModifiersAndPrecedencegroupKeyword: ExpressibleAsGarbageNodes? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    garbageBetweenPrecedencegroupKeywordAndIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: String,
    garbageBetweenIdentifierAndLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndGroupAttributes: ExpressibleAsGarbageNodes? = nil,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    garbageBetweenGroupAttributesAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndModifiers: garbageBetweenAttributesAndModifiers,
      modifiers: modifiers,
      garbageBetweenModifiersAndPrecedencegroupKeyword: garbageBetweenModifiersAndPrecedencegroupKeyword,
      precedencegroupKeyword: precedencegroupKeyword,
      garbageBetweenPrecedencegroupKeywordAndIdentifier: garbageBetweenPrecedencegroupKeywordAndIdentifier,
      identifier: TokenSyntax.identifier(identifier),
      garbageBetweenIdentifierAndLeftBrace: garbageBetweenIdentifierAndLeftBrace,
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndGroupAttributes: garbageBetweenLeftBraceAndGroupAttributes,
      groupAttributes: groupAttributes,
      garbageBetweenGroupAttributesAndRightBrace: garbageBetweenGroupAttributesAndRightBrace,
      rightBrace: rightBrace
    )
  }

  /// Builds a `PrecedenceGroupDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupDeclSyntax`.
  func buildPrecedenceGroupDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupDeclSyntax {
    let result = SyntaxFactory.makePrecedenceGroupDecl(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndModifiers?.buildGarbageNodes(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      garbageBetweenModifiersAndPrecedencegroupKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      precedencegroupKeyword: precedencegroupKeyword,
      garbageBetweenPrecedencegroupKeywordAndIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier,
      garbageBetweenIdentifierAndLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndGroupAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      groupAttributes: groupAttributes.buildPrecedenceGroupAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenGroupAttributesAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPrecedenceGroupDecl(format: format, leadingTrivia: additionalLeadingTrivia)
    return DeclSyntax(result)
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupDecl`.
  public func createPrecedenceGroupDecl() -> PrecedenceGroupDecl {
    return self
  }

  /// `PrecedenceGroupDecl` might conform to `ExpressibleAsDeclBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createDeclBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createDeclBuildable() -> DeclBuildable {
    return self
  }

  /// `PrecedenceGroupDecl` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// Specify the new precedence group's relation to existing precedencegroups.
public struct PrecedenceGroupRelation: SyntaxBuildable, ExpressibleAsPrecedenceGroupRelation {
  let garbageBeforeHigherThanOrLowerThan: GarbageNodes?
  let higherThanOrLowerThan: TokenSyntax
  let garbageBetweenHigherThanOrLowerThanAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndOtherNames: GarbageNodes?
  let otherNames: PrecedenceGroupNameList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupRelation` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeHigherThanOrLowerThan: 
  ///   - higherThanOrLowerThan: The relation to specified other precedence groups.
  ///   - garbageBetweenHigherThanOrLowerThanAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndOtherNames: 
  ///   - otherNames: The name of other precedence group to which this precedencegroup relates.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeHigherThanOrLowerThan: ExpressibleAsGarbageNodes? = nil,
    higherThanOrLowerThan: TokenSyntax,
    garbageBetweenHigherThanOrLowerThanAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndOtherNames: ExpressibleAsGarbageNodes? = nil,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeHigherThanOrLowerThan = garbageBeforeHigherThanOrLowerThan?.createGarbageNodes()
    self.higherThanOrLowerThan = higherThanOrLowerThan
    assert(higherThanOrLowerThan.text == "higherThan" || higherThanOrLowerThan.text == "lowerThan")
    self.garbageBetweenHigherThanOrLowerThanAndColon = garbageBetweenHigherThanOrLowerThanAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndOtherNames = garbageBetweenColonAndOtherNames?.createGarbageNodes()
    self.otherNames = otherNames.createPrecedenceGroupNameList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeHigherThanOrLowerThan: ExpressibleAsGarbageNodes? = nil,
    higherThanOrLowerThan: String,
    garbageBetweenHigherThanOrLowerThanAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndOtherNames: ExpressibleAsGarbageNodes? = nil,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeHigherThanOrLowerThan: garbageBeforeHigherThanOrLowerThan,
      higherThanOrLowerThan: TokenSyntax.identifier(higherThanOrLowerThan),
      garbageBetweenHigherThanOrLowerThanAndColon: garbageBetweenHigherThanOrLowerThanAndColon,
      colon: colon,
      garbageBetweenColonAndOtherNames: garbageBetweenColonAndOtherNames,
      otherNames: otherNames
    )
  }

  /// Builds a `PrecedenceGroupRelationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupRelationSyntax`.
  func buildPrecedenceGroupRelation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupRelationSyntax {
    let result = SyntaxFactory.makePrecedenceGroupRelation(
      garbageBeforeHigherThanOrLowerThan?.buildGarbageNodes(format: format, leadingTrivia: nil),
      higherThanOrLowerThan: higherThanOrLowerThan,
      garbageBetweenHigherThanOrLowerThanAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndOtherNames?.buildGarbageNodes(format: format, leadingTrivia: nil),
      otherNames: otherNames.buildPrecedenceGroupNameList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupRelation(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupRelation`.
  public func createPrecedenceGroupRelation() -> PrecedenceGroupRelation {
    return self
  }

  /// `PrecedenceGroupRelation` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PrecedenceGroupNameElement: SyntaxBuildable, ExpressibleAsPrecedenceGroupNameElement {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupNameElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndTrailingComma = garbageBetweenNameAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndTrailingComma: garbageBetweenNameAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `PrecedenceGroupNameElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupNameElementSyntax`.
  func buildPrecedenceGroupNameElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupNameElementSyntax {
    let result = SyntaxFactory.makePrecedenceGroupNameElement(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupNameElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupNameElement`.
  public func createPrecedenceGroupNameElement() -> PrecedenceGroupNameElement {
    return self
  }

  /// `PrecedenceGroupNameElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// Specifies the precedence of an operator when used in an operationthat includes optional chaining.
public struct PrecedenceGroupAssignment: SyntaxBuildable, ExpressibleAsPrecedenceGroupAssignment {
  let garbageBeforeAssignmentKeyword: GarbageNodes?
  let assignmentKeyword: TokenSyntax
  let garbageBetweenAssignmentKeywordAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndFlag: GarbageNodes?
  let flag: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupAssignment` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAssignmentKeyword: 
  ///   - assignmentKeyword: 
  ///   - garbageBetweenAssignmentKeywordAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndFlag: 
  ///   - flag: When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAssignmentKeyword: ExpressibleAsGarbageNodes? = nil,
    assignmentKeyword: TokenSyntax,
    garbageBetweenAssignmentKeywordAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndFlag: ExpressibleAsGarbageNodes? = nil,
    flag: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAssignmentKeyword = garbageBeforeAssignmentKeyword?.createGarbageNodes()
    self.assignmentKeyword = assignmentKeyword
    assert(assignmentKeyword.text == "assignment")
    self.garbageBetweenAssignmentKeywordAndColon = garbageBetweenAssignmentKeywordAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndFlag = garbageBetweenColonAndFlag?.createGarbageNodes()
    self.flag = flag
    assert(flag.text == "true" || flag.text == "false")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAssignmentKeyword: ExpressibleAsGarbageNodes? = nil,
    assignmentKeyword: String,
    garbageBetweenAssignmentKeywordAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndFlag: ExpressibleAsGarbageNodes? = nil,
    flag: TokenSyntax
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAssignmentKeyword: garbageBeforeAssignmentKeyword,
      assignmentKeyword: TokenSyntax.identifier(assignmentKeyword),
      garbageBetweenAssignmentKeywordAndColon: garbageBetweenAssignmentKeywordAndColon,
      colon: colon,
      garbageBetweenColonAndFlag: garbageBetweenColonAndFlag,
      flag: flag
    )
  }

  /// Builds a `PrecedenceGroupAssignmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupAssignmentSyntax`.
  func buildPrecedenceGroupAssignment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupAssignmentSyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssignment(
      garbageBeforeAssignmentKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      assignmentKeyword: assignmentKeyword,
      garbageBetweenAssignmentKeywordAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndFlag?.buildGarbageNodes(format: format, leadingTrivia: nil),
      flag: flag
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupAssignment(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupAssignment`.
  public func createPrecedenceGroupAssignment() -> PrecedenceGroupAssignment {
    return self
  }

  /// `PrecedenceGroupAssignment` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// Specifies how a sequence of operators with the same precedence levelare grouped together in the absence of grouping parentheses.
public struct PrecedenceGroupAssociativity: SyntaxBuildable, ExpressibleAsPrecedenceGroupAssociativity {
  let garbageBeforeAssociativityKeyword: GarbageNodes?
  let associativityKeyword: TokenSyntax
  let garbageBetweenAssociativityKeywordAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndValue: GarbageNodes?
  let value: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupAssociativity` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAssociativityKeyword: 
  ///   - associativityKeyword: 
  ///   - garbageBetweenAssociativityKeywordAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndValue: 
  ///   - value: Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAssociativityKeyword: ExpressibleAsGarbageNodes? = nil,
    associativityKeyword: TokenSyntax,
    garbageBetweenAssociativityKeywordAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAssociativityKeyword = garbageBeforeAssociativityKeyword?.createGarbageNodes()
    self.associativityKeyword = associativityKeyword
    assert(associativityKeyword.text == "associativity")
    self.garbageBetweenAssociativityKeywordAndColon = garbageBetweenAssociativityKeywordAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndValue = garbageBetweenColonAndValue?.createGarbageNodes()
    self.value = value
    assert(value.text == "left" || value.text == "right" || value.text == "none")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAssociativityKeyword: ExpressibleAsGarbageNodes? = nil,
    associativityKeyword: String,
    garbageBetweenAssociativityKeywordAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAssociativityKeyword: garbageBeforeAssociativityKeyword,
      associativityKeyword: TokenSyntax.identifier(associativityKeyword),
      garbageBetweenAssociativityKeywordAndColon: garbageBetweenAssociativityKeywordAndColon,
      colon: colon,
      garbageBetweenColonAndValue: garbageBetweenColonAndValue,
      value: TokenSyntax.identifier(value)
    )
  }

  /// Builds a `PrecedenceGroupAssociativitySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupAssociativitySyntax`.
  func buildPrecedenceGroupAssociativity(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupAssociativitySyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssociativity(
      garbageBeforeAssociativityKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      associativityKeyword: associativityKeyword,
      garbageBetweenAssociativityKeywordAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      value: value
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupAssociativity(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupAssociativity`.
  public func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity {
    return self
  }

  /// `PrecedenceGroupAssociativity` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A custom `@` attribute.
public struct CustomAttribute: SyntaxBuildable, ExpressibleAsCustomAttribute {
  let garbageBeforeAtSignToken: GarbageNodes?
  let atSignToken: TokenSyntax
  let garbageBetweenAtSignTokenAndAttributeName: GarbageNodes?
  let attributeName: TypeBuildable
  let garbageBetweenAttributeNameAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax?
  let garbageBetweenLeftParenAndArgumentList: GarbageNodes?
  let argumentList: TupleExprElementList?
  let garbageBetweenArgumentListAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CustomAttribute` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAtSignToken: 
  ///   - atSignToken: The `@` sign.
  ///   - garbageBetweenAtSignTokenAndAttributeName: 
  ///   - attributeName: The name of the attribute.
  ///   - garbageBetweenAttributeNameAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArgumentList: 
  ///   - argumentList: 
  ///   - garbageBetweenArgumentListAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAtSignToken: ExpressibleAsGarbageNodes? = nil,
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    garbageBetweenAtSignTokenAndAttributeName: ExpressibleAsGarbageNodes? = nil,
    attributeName: ExpressibleAsTypeBuildable,
    garbageBetweenAttributeNameAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    argumentList: ExpressibleAsTupleExprElementList? = nil,
    garbageBetweenArgumentListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAtSignToken = garbageBeforeAtSignToken?.createGarbageNodes()
    self.atSignToken = atSignToken
    assert(atSignToken.text == "@")
    self.garbageBetweenAtSignTokenAndAttributeName = garbageBetweenAtSignTokenAndAttributeName?.createGarbageNodes()
    self.attributeName = attributeName.createTypeBuildable()
    self.garbageBetweenAttributeNameAndLeftParen = garbageBetweenAttributeNameAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.garbageBetweenLeftParenAndArgumentList = garbageBetweenLeftParenAndArgumentList?.createGarbageNodes()
    self.argumentList = argumentList?.createTupleExprElementList()
    self.garbageBetweenArgumentListAndRightParen = garbageBetweenArgumentListAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAtSignToken: ExpressibleAsGarbageNodes? = nil,
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    garbageBetweenAtSignTokenAndAttributeName: ExpressibleAsGarbageNodes? = nil,
    attributeName: ExpressibleAsTypeBuildable,
    garbageBetweenAttributeNameAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndArgumentList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenArgumentListAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAtSignToken: garbageBeforeAtSignToken,
      atSignToken: atSignToken,
      garbageBetweenAtSignTokenAndAttributeName: garbageBetweenAtSignTokenAndAttributeName,
      attributeName: attributeName,
      garbageBetweenAttributeNameAndLeftParen: garbageBetweenAttributeNameAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgumentList: garbageBetweenLeftParenAndArgumentList,
      argumentList: argumentListBuilder(),
      garbageBetweenArgumentListAndRightParen: garbageBetweenArgumentListAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `CustomAttributeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CustomAttributeSyntax`.
  func buildCustomAttribute(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CustomAttributeSyntax {
    let result = SyntaxFactory.makeCustomAttribute(
      garbageBeforeAtSignToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      atSignToken: atSignToken,
      garbageBetweenAtSignTokenAndAttributeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributeName: attributeName.buildType(format: format, leadingTrivia: nil),
      garbageBetweenAttributeNameAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgumentList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      argumentList: argumentList?.buildTupleExprElementList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentListAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCustomAttribute(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCustomAttribute`.
  public func createCustomAttribute() -> CustomAttribute {
    return self
  }

  /// `CustomAttribute` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// An `@` attribute.
public struct Attribute: SyntaxBuildable, ExpressibleAsAttribute {
  let garbageBeforeAtSignToken: GarbageNodes?
  let atSignToken: TokenSyntax
  let garbageBetweenAtSignTokenAndAttributeName: GarbageNodes?
  let attributeName: TokenSyntax
  let garbageBetweenAttributeNameAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax?
  let garbageBetweenLeftParenAndArgument: GarbageNodes?
  let argument: SyntaxBuildable?
  let garbageBetweenArgumentAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax?
  let garbageBetweenRightParenAndTokenList: GarbageNodes?
  let tokenList: TokenList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `Attribute` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAtSignToken: 
  ///   - atSignToken: The `@` sign.
  ///   - garbageBetweenAtSignTokenAndAttributeName: 
  ///   - attributeName: The name of the attribute.
  ///   - garbageBetweenAttributeNameAndLeftParen: 
  ///   - leftParen: If the attribute takes arguments, the opening parenthesis.
  ///   - garbageBetweenLeftParenAndArgument: 
  ///   - argument: The arguments of the attribute. In case the attributetakes multiple arguments, they are gather in theappropriate takes first.
  ///   - garbageBetweenArgumentAndRightParen: 
  ///   - rightParen: If the attribute takes arguments, the closing parenthesis.
  ///   - garbageBetweenRightParenAndTokenList: 
  ///   - tokenList: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAtSignToken: ExpressibleAsGarbageNodes? = nil,
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    garbageBetweenAtSignTokenAndAttributeName: ExpressibleAsGarbageNodes? = nil,
    attributeName: TokenSyntax,
    garbageBetweenAttributeNameAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndArgument: ExpressibleAsGarbageNodes? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    garbageBetweenArgumentAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil,
    garbageBetweenRightParenAndTokenList: ExpressibleAsGarbageNodes? = nil,
    tokenList: ExpressibleAsTokenList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAtSignToken = garbageBeforeAtSignToken?.createGarbageNodes()
    self.atSignToken = atSignToken
    assert(atSignToken.text == "@")
    self.garbageBetweenAtSignTokenAndAttributeName = garbageBetweenAtSignTokenAndAttributeName?.createGarbageNodes()
    self.attributeName = attributeName
    self.garbageBetweenAttributeNameAndLeftParen = garbageBetweenAttributeNameAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.garbageBetweenLeftParenAndArgument = garbageBetweenLeftParenAndArgument?.createGarbageNodes()
    self.argument = argument?.createSyntaxBuildable()
    self.garbageBetweenArgumentAndRightParen = garbageBetweenArgumentAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
    self.garbageBetweenRightParenAndTokenList = garbageBetweenRightParenAndTokenList?.createGarbageNodes()
    self.tokenList = tokenList?.createTokenList()
  }


  /// Builds a `AttributeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AttributeSyntax`.
  func buildAttribute(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AttributeSyntax {
    let result = SyntaxFactory.makeAttribute(
      garbageBeforeAtSignToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      atSignToken: atSignToken,
      garbageBetweenAtSignTokenAndAttributeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributeName: attributeName,
      garbageBetweenAttributeNameAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArgument?.buildGarbageNodes(format: format, leadingTrivia: nil),
      argument: argument?.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenArgumentAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      garbageBetweenRightParenAndTokenList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      tokenList: tokenList?.buildTokenList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAttribute(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAttribute`.
  public func createAttribute() -> Attribute {
    return self
  }

  /// `Attribute` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The availability argument for the _specialize attribute
public struct AvailabilityEntry: SyntaxBuildable, ExpressibleAsAvailabilityEntry {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndAvailabilityList: GarbageNodes?
  let availabilityList: AvailabilitySpecList
  let garbageBetweenAvailabilityListAndSemicolon: GarbageNodes?
  let semicolon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityEntry` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: The label of the argument
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: The colon separating the label and the value
  ///   - garbageBetweenColonAndAvailabilityList: 
  ///   - availabilityList: 
  ///   - garbageBetweenAvailabilityListAndSemicolon: 
  ///   - semicolon: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndAvailabilityList: ExpressibleAsGarbageNodes? = nil,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    garbageBetweenAvailabilityListAndSemicolon: ExpressibleAsGarbageNodes? = nil,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndAvailabilityList = garbageBetweenColonAndAvailabilityList?.createGarbageNodes()
    self.availabilityList = availabilityList.createAvailabilitySpecList()
    self.garbageBetweenAvailabilityListAndSemicolon = garbageBetweenAvailabilityListAndSemicolon?.createGarbageNodes()
    self.semicolon = semicolon
    assert(semicolon.text == ";")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: String,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndAvailabilityList: ExpressibleAsGarbageNodes? = nil,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    garbageBetweenAvailabilityListAndSemicolon: ExpressibleAsGarbageNodes? = nil,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabel: garbageBeforeLabel,
      label: TokenSyntax.identifier(label),
      garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
      colon: colon,
      garbageBetweenColonAndAvailabilityList: garbageBetweenColonAndAvailabilityList,
      availabilityList: availabilityList,
      garbageBetweenAvailabilityListAndSemicolon: garbageBetweenAvailabilityListAndSemicolon,
      semicolon: semicolon
    )
  }

  /// Builds a `AvailabilityEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityEntrySyntax`.
  func buildAvailabilityEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityEntrySyntax {
    let result = SyntaxFactory.makeAvailabilityEntry(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndAvailabilityList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      availabilityList: availabilityList.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      garbageBetweenAvailabilityListAndSemicolon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityEntry(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAvailabilityEntry`.
  public func createAvailabilityEntry() -> AvailabilityEntry {
    return self
  }

  /// `AvailabilityEntry` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A labeled argument for the `@_specialize` attribute like`exported: true`
public struct LabeledSpecializeEntry: SyntaxBuildable, ExpressibleAsLabeledSpecializeEntry, HasTrailingComma {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndValue: GarbageNodes?
  let value: TokenSyntax
  let garbageBetweenValueAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `LabeledSpecializeEntry` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: The label of the argument
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: The colon separating the label and the value
  ///   - garbageBetweenColonAndValue: 
  ///   - value: The value for this argument
  ///   - garbageBetweenValueAndTrailingComma: 
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: TokenSyntax,
    garbageBetweenValueAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndValue = garbageBetweenColonAndValue?.createGarbageNodes()
    self.value = value
    self.garbageBetweenValueAndTrailingComma = garbageBetweenValueAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: String,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: TokenSyntax,
    garbageBetweenValueAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabel: garbageBeforeLabel,
      label: TokenSyntax.identifier(label),
      garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
      colon: colon,
      garbageBetweenColonAndValue: garbageBetweenColonAndValue,
      value: value,
      garbageBetweenValueAndTrailingComma: garbageBetweenValueAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `LabeledSpecializeEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `LabeledSpecializeEntrySyntax`.
  func buildLabeledSpecializeEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> LabeledSpecializeEntrySyntax {
    let result = SyntaxFactory.makeLabeledSpecializeEntry(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      value: value,
      garbageBetweenValueAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildLabeledSpecializeEntry(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsLabeledSpecializeEntry`.
  public func createLabeledSpecializeEntry() -> LabeledSpecializeEntry {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeLabel: garbageBeforeLabel,
        label: label,
        garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
        colon: colon,
        garbageBetweenColonAndValue: garbageBetweenColonAndValue,
        value: value,
        garbageBetweenValueAndTrailingComma: garbageBetweenValueAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `LabeledSpecializeEntry` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A labeled argument for the `@_specialize` attribute with a functiondecl value like`target: myFunc(_:)`
public struct TargetFunctionEntry: SyntaxBuildable, ExpressibleAsTargetFunctionEntry, HasTrailingComma {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndDeclname: GarbageNodes?
  let declname: DeclName
  let garbageBetweenDeclnameAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TargetFunctionEntry` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: The label of the argument
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: The colon separating the label and the value
  ///   - garbageBetweenColonAndDeclname: 
  ///   - declname: The value for this argument
  ///   - garbageBetweenDeclnameAndTrailingComma: 
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndDeclname: ExpressibleAsGarbageNodes? = nil,
    declname: ExpressibleAsDeclName,
    garbageBetweenDeclnameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndDeclname = garbageBetweenColonAndDeclname?.createGarbageNodes()
    self.declname = declname.createDeclName()
    self.garbageBetweenDeclnameAndTrailingComma = garbageBetweenDeclnameAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: String,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndDeclname: ExpressibleAsGarbageNodes? = nil,
    declname: ExpressibleAsDeclName,
    garbageBetweenDeclnameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabel: garbageBeforeLabel,
      label: TokenSyntax.identifier(label),
      garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
      colon: colon,
      garbageBetweenColonAndDeclname: garbageBetweenColonAndDeclname,
      declname: declname,
      garbageBetweenDeclnameAndTrailingComma: garbageBetweenDeclnameAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `TargetFunctionEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TargetFunctionEntrySyntax`.
  func buildTargetFunctionEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TargetFunctionEntrySyntax {
    let result = SyntaxFactory.makeTargetFunctionEntry(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndDeclname?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declname: declname.buildDeclName(format: format, leadingTrivia: nil),
      garbageBetweenDeclnameAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTargetFunctionEntry(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTargetFunctionEntry`.
  public func createTargetFunctionEntry() -> TargetFunctionEntry {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeLabel: garbageBeforeLabel,
        label: label,
        garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
        colon: colon,
        garbageBetweenColonAndDeclname: garbageBetweenColonAndDeclname,
        declname: declname,
        garbageBetweenDeclnameAndTrailingComma: garbageBetweenDeclnameAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `TargetFunctionEntry` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The argument for the `@_dynamic_replacement` or `@_private`attribute of the form `for: "function()"` or `sourceFile:"Src.swift"`
public struct NamedAttributeStringArgument: SyntaxBuildable, ExpressibleAsNamedAttributeStringArgument {
  let garbageBeforeNameTok: GarbageNodes?
  let nameTok: TokenSyntax
  let garbageBetweenNameTokAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndStringOrDeclname: GarbageNodes?
  let stringOrDeclname: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `NamedAttributeStringArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeNameTok: 
  ///   - nameTok: The label of the argument
  ///   - garbageBetweenNameTokAndColon: 
  ///   - colon: The colon separating the label and the value
  ///   - garbageBetweenColonAndStringOrDeclname: 
  ///   - stringOrDeclname: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeNameTok: ExpressibleAsGarbageNodes? = nil,
    nameTok: TokenSyntax,
    garbageBetweenNameTokAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndStringOrDeclname: ExpressibleAsGarbageNodes? = nil,
    stringOrDeclname: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeNameTok = garbageBeforeNameTok?.createGarbageNodes()
    self.nameTok = nameTok
    self.garbageBetweenNameTokAndColon = garbageBetweenNameTokAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndStringOrDeclname = garbageBetweenColonAndStringOrDeclname?.createGarbageNodes()
    self.stringOrDeclname = stringOrDeclname.createSyntaxBuildable()
  }


  /// Builds a `NamedAttributeStringArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `NamedAttributeStringArgumentSyntax`.
  func buildNamedAttributeStringArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> NamedAttributeStringArgumentSyntax {
    let result = SyntaxFactory.makeNamedAttributeStringArgument(
      garbageBeforeNameTok?.buildGarbageNodes(format: format, leadingTrivia: nil),
      nameTok: nameTok,
      garbageBetweenNameTokAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndStringOrDeclname?.buildGarbageNodes(format: format, leadingTrivia: nil),
      stringOrDeclname: stringOrDeclname.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildNamedAttributeStringArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsNamedAttributeStringArgument`.
  public func createNamedAttributeStringArgument() -> NamedAttributeStringArgument {
    return self
  }

  /// `NamedAttributeStringArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DeclName: SyntaxBuildable, ExpressibleAsDeclName {
  let garbageBeforeDeclBaseName: GarbageNodes?
  let declBaseName: SyntaxBuildable
  let garbageBetweenDeclBaseNameAndDeclNameArguments: GarbageNodes?
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclName` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDeclBaseName: 
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - garbageBetweenDeclBaseNameAndDeclNameArguments: 
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDeclBaseName: ExpressibleAsGarbageNodes? = nil,
    declBaseName: ExpressibleAsSyntaxBuildable,
    garbageBetweenDeclBaseNameAndDeclNameArguments: ExpressibleAsGarbageNodes? = nil,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDeclBaseName = garbageBeforeDeclBaseName?.createGarbageNodes()
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.garbageBetweenDeclBaseNameAndDeclNameArguments = garbageBetweenDeclBaseNameAndDeclNameArguments?.createGarbageNodes()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `DeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameSyntax`.
  func buildDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameSyntax {
    let result = SyntaxFactory.makeDeclName(
      garbageBeforeDeclBaseName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenDeclBaseNameAndDeclNameArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclName(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDeclName`.
  public func createDeclName() -> DeclName {
    return self
  }

  /// `DeclName` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The arguments for the `@_implements` attribute of the form`Type, methodName(arg1Label:arg2Label:)`
public struct ImplementsAttributeArguments: SyntaxBuildable, ExpressibleAsImplementsAttributeArguments {
  let garbageBeforeType: GarbageNodes?
  let type: SimpleTypeIdentifier
  let garbageBetweenTypeAndComma: GarbageNodes?
  let comma: TokenSyntax
  let garbageBetweenCommaAndDeclBaseName: GarbageNodes?
  let declBaseName: SyntaxBuildable
  let garbageBetweenDeclBaseNameAndDeclNameArguments: GarbageNodes?
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImplementsAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeType: 
  ///   - type: The type for which the method with this attributeimplements a requirement.
  ///   - garbageBetweenTypeAndComma: 
  ///   - comma: The comma separating the type and method name
  ///   - garbageBetweenCommaAndDeclBaseName: 
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - garbageBetweenDeclBaseNameAndDeclNameArguments: 
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsSimpleTypeIdentifier,
    garbageBetweenTypeAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax = TokenSyntax.`comma`,
    garbageBetweenCommaAndDeclBaseName: ExpressibleAsGarbageNodes? = nil,
    declBaseName: ExpressibleAsSyntaxBuildable,
    garbageBetweenDeclBaseNameAndDeclNameArguments: ExpressibleAsGarbageNodes? = nil,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeType = garbageBeforeType?.createGarbageNodes()
    self.type = type.createSimpleTypeIdentifier()
    self.garbageBetweenTypeAndComma = garbageBetweenTypeAndComma?.createGarbageNodes()
    self.comma = comma
    assert(comma.text == ",")
    self.garbageBetweenCommaAndDeclBaseName = garbageBetweenCommaAndDeclBaseName?.createGarbageNodes()
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.garbageBetweenDeclBaseNameAndDeclNameArguments = garbageBetweenDeclBaseNameAndDeclNameArguments?.createGarbageNodes()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `ImplementsAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImplementsAttributeArgumentsSyntax`.
  func buildImplementsAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImplementsAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeImplementsAttributeArguments(
      garbageBeforeType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildSimpleTypeIdentifier(format: format, leadingTrivia: nil),
      garbageBetweenTypeAndComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      comma: comma,
      garbageBetweenCommaAndDeclBaseName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenDeclBaseNameAndDeclNameArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildImplementsAttributeArguments(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsImplementsAttributeArguments`.
  public func createImplementsAttributeArguments() -> ImplementsAttributeArguments {
    return self
  }

  /// `ImplementsAttributeArguments` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A piece of an Objective-C selector. Either consisting of just anidentifier for a nullary selector, an identifier and a colon for alabeled argument or just a colon for an unlabeled argument
public struct ObjCSelectorPiece: SyntaxBuildable, ExpressibleAsObjCSelectorPiece {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax?
  let garbageBetweenNameAndColon: GarbageNodes?
  let colon: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjCSelectorPiece` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndColon: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax? = nil,
    garbageBetweenNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndColon = garbageBetweenNameAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String?,
    garbageBetweenNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: name.map(TokenSyntax.identifier),
      garbageBetweenNameAndColon: garbageBetweenNameAndColon,
      colon: colon
    )
  }

  /// Builds a `ObjCSelectorPieceSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjCSelectorPieceSyntax`.
  func buildObjCSelectorPiece(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjCSelectorPieceSyntax {
    let result = SyntaxFactory.makeObjCSelectorPiece(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildObjCSelectorPiece(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsObjCSelectorPiece`.
  public func createObjCSelectorPiece() -> ObjCSelectorPiece {
    return self
  }

  /// `ObjCSelectorPiece` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The arguments for the `@differentiable` attribute: an optionaldifferentiability kind, an optional differentiability parameter clause,and an optional 'where' clause.
public struct DifferentiableAttributeArguments: SyntaxBuildable, ExpressibleAsDifferentiableAttributeArguments {
  let garbageBeforeDiffKind: GarbageNodes?
  let diffKind: TokenSyntax?
  let garbageBetweenDiffKindAndDiffKindComma: GarbageNodes?
  let diffKindComma: TokenSyntax?
  let garbageBetweenDiffKindCommaAndDiffParams: GarbageNodes?
  let diffParams: DifferentiabilityParamsClause?
  let garbageBetweenDiffParamsAndDiffParamsComma: GarbageNodes?
  let diffParamsComma: TokenSyntax?
  let garbageBetweenDiffParamsCommaAndWhereClause: GarbageNodes?
  let whereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiableAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDiffKind: 
  ///   - diffKind: 
  ///   - garbageBetweenDiffKindAndDiffKindComma: 
  ///   - diffKindComma: The comma following the differentiability kind, if it exists.
  ///   - garbageBetweenDiffKindCommaAndDiffParams: 
  ///   - diffParams: 
  ///   - garbageBetweenDiffParamsAndDiffParamsComma: 
  ///   - diffParamsComma: The comma following the differentiability parameters clause,if it exists.
  ///   - garbageBetweenDiffParamsCommaAndWhereClause: 
  ///   - whereClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDiffKind: ExpressibleAsGarbageNodes? = nil,
    diffKind: TokenSyntax? = nil,
    garbageBetweenDiffKindAndDiffKindComma: ExpressibleAsGarbageNodes? = nil,
    diffKindComma: TokenSyntax? = nil,
    garbageBetweenDiffKindCommaAndDiffParams: ExpressibleAsGarbageNodes? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    garbageBetweenDiffParamsAndDiffParamsComma: ExpressibleAsGarbageNodes? = nil,
    diffParamsComma: TokenSyntax? = nil,
    garbageBetweenDiffParamsCommaAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDiffKind = garbageBeforeDiffKind?.createGarbageNodes()
    self.diffKind = diffKind
    assert(diffKind == nil || diffKind!.text == "forward" || diffKind!.text == "reverse" || diffKind!.text == "linear")
    self.garbageBetweenDiffKindAndDiffKindComma = garbageBetweenDiffKindAndDiffKindComma?.createGarbageNodes()
    self.diffKindComma = diffKindComma
    assert(diffKindComma == nil || diffKindComma!.text == ",")
    self.garbageBetweenDiffKindCommaAndDiffParams = garbageBetweenDiffKindCommaAndDiffParams?.createGarbageNodes()
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
    self.garbageBetweenDiffParamsAndDiffParamsComma = garbageBetweenDiffParamsAndDiffParamsComma?.createGarbageNodes()
    self.diffParamsComma = diffParamsComma
    assert(diffParamsComma == nil || diffParamsComma!.text == ",")
    self.garbageBetweenDiffParamsCommaAndWhereClause = garbageBetweenDiffParamsCommaAndWhereClause?.createGarbageNodes()
    self.whereClause = whereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDiffKind: ExpressibleAsGarbageNodes? = nil,
    diffKind: String?,
    garbageBetweenDiffKindAndDiffKindComma: ExpressibleAsGarbageNodes? = nil,
    diffKindComma: TokenSyntax? = nil,
    garbageBetweenDiffKindCommaAndDiffParams: ExpressibleAsGarbageNodes? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    garbageBetweenDiffParamsAndDiffParamsComma: ExpressibleAsGarbageNodes? = nil,
    diffParamsComma: TokenSyntax? = nil,
    garbageBetweenDiffParamsCommaAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeDiffKind: garbageBeforeDiffKind,
      diffKind: diffKind.map(TokenSyntax.identifier),
      garbageBetweenDiffKindAndDiffKindComma: garbageBetweenDiffKindAndDiffKindComma,
      diffKindComma: diffKindComma,
      garbageBetweenDiffKindCommaAndDiffParams: garbageBetweenDiffKindCommaAndDiffParams,
      diffParams: diffParams,
      garbageBetweenDiffParamsAndDiffParamsComma: garbageBetweenDiffParamsAndDiffParamsComma,
      diffParamsComma: diffParamsComma,
      garbageBetweenDiffParamsCommaAndWhereClause: garbageBetweenDiffParamsCommaAndWhereClause,
      whereClause: whereClause
    )
  }

  /// Builds a `DifferentiableAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiableAttributeArgumentsSyntax`.
  func buildDifferentiableAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiableAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDifferentiableAttributeArguments(
      garbageBeforeDiffKind?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffKind: diffKind,
      garbageBetweenDiffKindAndDiffKindComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffKindComma: diffKindComma,
      garbageBetweenDiffKindCommaAndDiffParams?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil),
      garbageBetweenDiffParamsAndDiffParamsComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffParamsComma: diffParamsComma,
      garbageBetweenDiffParamsCommaAndWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiableAttributeArguments(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDifferentiableAttributeArguments`.
  public func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments {
    return self
  }

  /// `DifferentiableAttributeArguments` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A clause containing differentiability parameters.
public struct DifferentiabilityParamsClause: SyntaxBuildable, ExpressibleAsDifferentiabilityParamsClause {
  let garbageBeforeWrtLabel: GarbageNodes?
  let wrtLabel: TokenSyntax
  let garbageBetweenWrtLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndParameters: GarbageNodes?
  let parameters: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParamsClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWrtLabel: 
  ///   - wrtLabel: The "wrt" label.
  ///   - garbageBetweenWrtLabelAndColon: 
  ///   - colon: The colon separating "wrt" and the parameter list.
  ///   - garbageBetweenColonAndParameters: 
  ///   - parameters: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWrtLabel: ExpressibleAsGarbageNodes? = nil,
    wrtLabel: TokenSyntax,
    garbageBetweenWrtLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndParameters: ExpressibleAsGarbageNodes? = nil,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWrtLabel = garbageBeforeWrtLabel?.createGarbageNodes()
    self.wrtLabel = wrtLabel
    assert(wrtLabel.text == "wrt")
    self.garbageBetweenWrtLabelAndColon = garbageBetweenWrtLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndParameters = garbageBetweenColonAndParameters?.createGarbageNodes()
    self.parameters = parameters.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWrtLabel: ExpressibleAsGarbageNodes? = nil,
    wrtLabel: String,
    garbageBetweenWrtLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndParameters: ExpressibleAsGarbageNodes? = nil,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeWrtLabel: garbageBeforeWrtLabel,
      wrtLabel: TokenSyntax.identifier(wrtLabel),
      garbageBetweenWrtLabelAndColon: garbageBetweenWrtLabelAndColon,
      colon: colon,
      garbageBetweenColonAndParameters: garbageBetweenColonAndParameters,
      parameters: parameters
    )
  }

  /// Builds a `DifferentiabilityParamsClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamsClauseSyntax`.
  func buildDifferentiabilityParamsClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamsClauseSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParamsClause(
      garbageBeforeWrtLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      wrtLabel: wrtLabel,
      garbageBetweenWrtLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndParameters?.buildGarbageNodes(format: format, leadingTrivia: nil),
      parameters: parameters.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParamsClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDifferentiabilityParamsClause`.
  public func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause {
    return self
  }

  /// `DifferentiabilityParamsClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The differentiability parameters.
public struct DifferentiabilityParams: SyntaxBuildable, ExpressibleAsDifferentiabilityParams {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndDiffParams: GarbageNodes?
  let diffParams: DifferentiabilityParamList
  let garbageBetweenDiffParamsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParams` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndDiffParams: 
  ///   - diffParams: The parameters for differentiation.
  ///   - garbageBetweenDiffParamsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndDiffParams: ExpressibleAsGarbageNodes? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamList,
    garbageBetweenDiffParamsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndDiffParams = garbageBetweenLeftParenAndDiffParams?.createGarbageNodes()
    self.diffParams = diffParams.createDifferentiabilityParamList()
    self.garbageBetweenDiffParamsAndRightParen = garbageBetweenDiffParamsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `DifferentiabilityParamsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamsSyntax`.
  func buildDifferentiabilityParams(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamsSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParams(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndDiffParams?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffParams: diffParams.buildDifferentiabilityParamList(format: format, leadingTrivia: nil),
      garbageBetweenDiffParamsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParams(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDifferentiabilityParams`.
  public func createDifferentiabilityParams() -> DifferentiabilityParams {
    return self
  }

  /// `DifferentiabilityParams` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A differentiability parameter: either the "self" identifier, a functionparameter name, or a function parameter index.
public struct DifferentiabilityParam: SyntaxBuildable, ExpressibleAsDifferentiabilityParam, HasTrailingComma {
  let garbageBeforeParameter: GarbageNodes?
  let parameter: SyntaxBuildable
  let garbageBetweenParameterAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParam` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeParameter: 
  ///   - parameter: 
  ///   - garbageBetweenParameterAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeParameter: ExpressibleAsGarbageNodes? = nil,
    parameter: ExpressibleAsSyntaxBuildable,
    garbageBetweenParameterAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeParameter = garbageBeforeParameter?.createGarbageNodes()
    self.parameter = parameter.createSyntaxBuildable()
    self.garbageBetweenParameterAndTrailingComma = garbageBetweenParameterAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `DifferentiabilityParamSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamSyntax`.
  func buildDifferentiabilityParam(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParam(
      garbageBeforeParameter?.buildGarbageNodes(format: format, leadingTrivia: nil),
      parameter: parameter.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenParameterAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParam(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDifferentiabilityParam`.
  public func createDifferentiabilityParam() -> DifferentiabilityParam {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeParameter: garbageBeforeParameter,
        parameter: parameter,
        garbageBetweenParameterAndTrailingComma: garbageBetweenParameterAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `DifferentiabilityParam` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// The arguments for the '@derivative(of:)' and '@transpose(of:)'attributes: the 'of:' label, the original declaration name, and anoptional differentiability parameter list.
public struct DerivativeRegistrationAttributeArguments: SyntaxBuildable, ExpressibleAsDerivativeRegistrationAttributeArguments {
  let garbageBeforeOfLabel: GarbageNodes?
  let ofLabel: TokenSyntax
  let garbageBetweenOfLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndOriginalDeclName: GarbageNodes?
  let originalDeclName: QualifiedDeclName
  let garbageBetweenOriginalDeclNameAndPeriod: GarbageNodes?
  let period: TokenSyntax?
  let garbageBetweenPeriodAndAccessorKind: GarbageNodes?
  let accessorKind: TokenSyntax?
  let garbageBetweenAccessorKindAndComma: GarbageNodes?
  let comma: TokenSyntax?
  let garbageBetweenCommaAndDiffParams: GarbageNodes?
  let diffParams: DifferentiabilityParamsClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DerivativeRegistrationAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeOfLabel: 
  ///   - ofLabel: The "of" label.
  ///   - garbageBetweenOfLabelAndColon: 
  ///   - colon: The colon separating the "of" label and the originaldeclaration name.
  ///   - garbageBetweenColonAndOriginalDeclName: 
  ///   - originalDeclName: The referenced original declaration name.
  ///   - garbageBetweenOriginalDeclNameAndPeriod: 
  ///   - period: The period separating the original declaration name and theaccessor name.
  ///   - garbageBetweenPeriodAndAccessorKind: 
  ///   - accessorKind: The accessor name.
  ///   - garbageBetweenAccessorKindAndComma: 
  ///   - comma: 
  ///   - garbageBetweenCommaAndDiffParams: 
  ///   - diffParams: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOfLabel: ExpressibleAsGarbageNodes? = nil,
    ofLabel: TokenSyntax,
    garbageBetweenOfLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndOriginalDeclName: ExpressibleAsGarbageNodes? = nil,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    garbageBetweenOriginalDeclNameAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax? = nil,
    garbageBetweenPeriodAndAccessorKind: ExpressibleAsGarbageNodes? = nil,
    accessorKind: TokenSyntax? = nil,
    garbageBetweenAccessorKindAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndDiffParams: ExpressibleAsGarbageNodes? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeOfLabel = garbageBeforeOfLabel?.createGarbageNodes()
    self.ofLabel = ofLabel
    assert(ofLabel.text == "of")
    self.garbageBetweenOfLabelAndColon = garbageBetweenOfLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndOriginalDeclName = garbageBetweenColonAndOriginalDeclName?.createGarbageNodes()
    self.originalDeclName = originalDeclName.createQualifiedDeclName()
    self.garbageBetweenOriginalDeclNameAndPeriod = garbageBetweenOriginalDeclNameAndPeriod?.createGarbageNodes()
    self.period = period
    assert(period == nil || period!.text == ".")
    self.garbageBetweenPeriodAndAccessorKind = garbageBetweenPeriodAndAccessorKind?.createGarbageNodes()
    self.accessorKind = accessorKind
    assert(accessorKind == nil || accessorKind!.text == "get" || accessorKind!.text == "set")
    self.garbageBetweenAccessorKindAndComma = garbageBetweenAccessorKindAndComma?.createGarbageNodes()
    self.comma = comma
    assert(comma == nil || comma!.text == ",")
    self.garbageBetweenCommaAndDiffParams = garbageBetweenCommaAndDiffParams?.createGarbageNodes()
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeOfLabel: ExpressibleAsGarbageNodes? = nil,
    ofLabel: String,
    garbageBetweenOfLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndOriginalDeclName: ExpressibleAsGarbageNodes? = nil,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    garbageBetweenOriginalDeclNameAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax? = nil,
    garbageBetweenPeriodAndAccessorKind: ExpressibleAsGarbageNodes? = nil,
    accessorKind: String?,
    garbageBetweenAccessorKindAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndDiffParams: ExpressibleAsGarbageNodes? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeOfLabel: garbageBeforeOfLabel,
      ofLabel: TokenSyntax.identifier(ofLabel),
      garbageBetweenOfLabelAndColon: garbageBetweenOfLabelAndColon,
      colon: colon,
      garbageBetweenColonAndOriginalDeclName: garbageBetweenColonAndOriginalDeclName,
      originalDeclName: originalDeclName,
      garbageBetweenOriginalDeclNameAndPeriod: garbageBetweenOriginalDeclNameAndPeriod,
      period: period,
      garbageBetweenPeriodAndAccessorKind: garbageBetweenPeriodAndAccessorKind,
      accessorKind: accessorKind.map(TokenSyntax.identifier),
      garbageBetweenAccessorKindAndComma: garbageBetweenAccessorKindAndComma,
      comma: comma,
      garbageBetweenCommaAndDiffParams: garbageBetweenCommaAndDiffParams,
      diffParams: diffParams
    )
  }

  /// Builds a `DerivativeRegistrationAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DerivativeRegistrationAttributeArgumentsSyntax`.
  func buildDerivativeRegistrationAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDerivativeRegistrationAttributeArguments(
      garbageBeforeOfLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ofLabel: ofLabel,
      garbageBetweenOfLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndOriginalDeclName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      originalDeclName: originalDeclName.buildQualifiedDeclName(format: format, leadingTrivia: nil),
      garbageBetweenOriginalDeclNameAndPeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      period: period,
      garbageBetweenPeriodAndAccessorKind?.buildGarbageNodes(format: format, leadingTrivia: nil),
      accessorKind: accessorKind,
      garbageBetweenAccessorKindAndComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      comma: comma,
      garbageBetweenCommaAndDiffParams?.buildGarbageNodes(format: format, leadingTrivia: nil),
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDerivativeRegistrationAttributeArguments(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDerivativeRegistrationAttributeArguments`.
  public func createDerivativeRegistrationAttributeArguments() -> DerivativeRegistrationAttributeArguments {
    return self
  }

  /// `DerivativeRegistrationAttributeArguments` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// An optionally qualified function declaration name (e.g. `+(_:_:)`,`A.B.C.foo(_:_:)`).
public struct QualifiedDeclName: SyntaxBuildable, ExpressibleAsQualifiedDeclName {
  let garbageBeforeBaseType: GarbageNodes?
  let baseType: TypeBuildable?
  let garbageBetweenBaseTypeAndDot: GarbageNodes?
  let dot: TokenSyntax?
  let garbageBetweenDotAndName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndArguments: GarbageNodes?
  let arguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `QualifiedDeclName` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBaseType: 
  ///   - baseType: The base type of the qualified name, optionally specified.
  ///   - garbageBetweenBaseTypeAndDot: 
  ///   - dot: 
  ///   - garbageBetweenDotAndName: 
  ///   - name: The base name of the referenced function.
  ///   - garbageBetweenNameAndArguments: 
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenBaseTypeAndDot: ExpressibleAsGarbageNodes? = nil,
    dot: TokenSyntax? = nil,
    garbageBetweenDotAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBaseType = garbageBeforeBaseType?.createGarbageNodes()
    self.baseType = baseType?.createTypeBuildable()
    self.garbageBetweenBaseTypeAndDot = garbageBetweenBaseTypeAndDot?.createGarbageNodes()
    self.dot = dot
    assert(dot == nil || dot!.text == "." || dot!.text == ".")
    self.garbageBetweenDotAndName = garbageBetweenDotAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndArguments = garbageBetweenNameAndArguments?.createGarbageNodes()
    self.arguments = arguments?.createDeclNameArguments()
  }


  /// Builds a `QualifiedDeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `QualifiedDeclNameSyntax`.
  func buildQualifiedDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> QualifiedDeclNameSyntax {
    let result = SyntaxFactory.makeQualifiedDeclName(
      garbageBeforeBaseType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      baseType: baseType?.buildType(format: format, leadingTrivia: nil),
      garbageBetweenBaseTypeAndDot?.buildGarbageNodes(format: format, leadingTrivia: nil),
      dot: dot,
      garbageBetweenDotAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildQualifiedDeclName(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsQualifiedDeclName`.
  public func createQualifiedDeclName() -> QualifiedDeclName {
    return self
  }

  /// `QualifiedDeclName` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclName: SyntaxBuildable, ExpressibleAsFunctionDeclName {
  let garbageBeforeName: GarbageNodes?
  let name: SyntaxBuildable
  let garbageBetweenNameAndArguments: GarbageNodes?
  let arguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionDeclName` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: The base name of the referenced function.
  ///   - garbageBetweenNameAndArguments: 
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: ExpressibleAsSyntaxBuildable,
    garbageBetweenNameAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name.createSyntaxBuildable()
    self.garbageBetweenNameAndArguments = garbageBetweenNameAndArguments?.createGarbageNodes()
    self.arguments = arguments?.createDeclNameArguments()
  }


  /// Builds a `FunctionDeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionDeclNameSyntax`.
  func buildFunctionDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionDeclNameSyntax {
    let result = SyntaxFactory.makeFunctionDeclName(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenNameAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionDeclName(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionDeclName`.
  public func createFunctionDeclName() -> FunctionDeclName {
    return self
  }

  /// `FunctionDeclName` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A collection of arguments for the `@_backDeploy` attribute
public struct BackDeployAttributeSpecList: SyntaxBuildable, ExpressibleAsBackDeployAttributeSpecList {
  let garbageBeforeBeforeLabel: GarbageNodes?
  let beforeLabel: TokenSyntax
  let garbageBetweenBeforeLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndVersionList: GarbageNodes?
  let versionList: BackDeployVersionList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BackDeployAttributeSpecList` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBeforeLabel: 
  ///   - beforeLabel: The "before" label.
  ///   - garbageBetweenBeforeLabelAndColon: 
  ///   - colon: The colon separating "before" and the parameter list.
  ///   - garbageBetweenColonAndVersionList: 
  ///   - versionList: The list of OS versions in which the declaration became ABIstable.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    beforeLabel: TokenSyntax,
    garbageBetweenBeforeLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndVersionList: ExpressibleAsGarbageNodes? = nil,
    versionList: ExpressibleAsBackDeployVersionList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBeforeLabel = garbageBeforeBeforeLabel?.createGarbageNodes()
    self.beforeLabel = beforeLabel
    assert(beforeLabel.text == "before")
    self.garbageBetweenBeforeLabelAndColon = garbageBetweenBeforeLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndVersionList = garbageBetweenColonAndVersionList?.createGarbageNodes()
    self.versionList = versionList.createBackDeployVersionList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    beforeLabel: String,
    garbageBetweenBeforeLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndVersionList: ExpressibleAsGarbageNodes? = nil,
    versionList: ExpressibleAsBackDeployVersionList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeBeforeLabel: garbageBeforeBeforeLabel,
      beforeLabel: TokenSyntax.identifier(beforeLabel),
      garbageBetweenBeforeLabelAndColon: garbageBetweenBeforeLabelAndColon,
      colon: colon,
      garbageBetweenColonAndVersionList: garbageBetweenColonAndVersionList,
      versionList: versionList
    )
  }

  /// Builds a `BackDeployAttributeSpecListSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BackDeployAttributeSpecListSyntax`.
  func buildBackDeployAttributeSpecList(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BackDeployAttributeSpecListSyntax {
    let result = SyntaxFactory.makeBackDeployAttributeSpecList(
      garbageBeforeBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      beforeLabel: beforeLabel,
      garbageBetweenBeforeLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndVersionList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      versionList: versionList.buildBackDeployVersionList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildBackDeployAttributeSpecList(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsBackDeployAttributeSpecList`.
  public func createBackDeployAttributeSpecList() -> BackDeployAttributeSpecList {
    return self
  }

  /// `BackDeployAttributeSpecList` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A single platform/version pair in a `@_backDeploy` attribute,e.g. `iOS 10.1`.
public struct BackDeployVersionArgument: SyntaxBuildable, ExpressibleAsBackDeployVersionArgument {
  let garbageBeforeAvailabilityVersionRestriction: GarbageNodes?
  let availabilityVersionRestriction: AvailabilityVersionRestriction
  let garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BackDeployVersionArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAvailabilityVersionRestriction: 
  ///   - availabilityVersionRestriction: 
  ///   - garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: 
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAvailabilityVersionRestriction: ExpressibleAsGarbageNodes? = nil,
    availabilityVersionRestriction: ExpressibleAsAvailabilityVersionRestriction,
    garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAvailabilityVersionRestriction = garbageBeforeAvailabilityVersionRestriction?.createGarbageNodes()
    self.availabilityVersionRestriction = availabilityVersionRestriction.createAvailabilityVersionRestriction()
    self.garbageBetweenAvailabilityVersionRestrictionAndTrailingComma = garbageBetweenAvailabilityVersionRestrictionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `BackDeployVersionArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BackDeployVersionArgumentSyntax`.
  func buildBackDeployVersionArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BackDeployVersionArgumentSyntax {
    let result = SyntaxFactory.makeBackDeployVersionArgument(
      garbageBeforeAvailabilityVersionRestriction?.buildGarbageNodes(format: format, leadingTrivia: nil),
      availabilityVersionRestriction: availabilityVersionRestriction.buildAvailabilityVersionRestriction(format: format, leadingTrivia: nil),
      garbageBetweenAvailabilityVersionRestrictionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildBackDeployVersionArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsBackDeployVersionArgument`.
  public func createBackDeployVersionArgument() -> BackDeployVersionArgument {
    return self
  }

  /// `BackDeployVersionArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct LabeledStmt: StmtBuildable, ExpressibleAsLabeledStmt {
  let garbageBeforeLabelName: GarbageNodes?
  let labelName: TokenSyntax
  let garbageBetweenLabelNameAndLabelColon: GarbageNodes?
  let labelColon: TokenSyntax
  let garbageBetweenLabelColonAndStatement: GarbageNodes?
  let statement: StmtBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `LabeledStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabelName: 
  ///   - labelName: 
  ///   - garbageBetweenLabelNameAndLabelColon: 
  ///   - labelColon: 
  ///   - garbageBetweenLabelColonAndStatement: 
  ///   - statement: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabelName: ExpressibleAsGarbageNodes? = nil,
    labelName: TokenSyntax,
    garbageBetweenLabelNameAndLabelColon: ExpressibleAsGarbageNodes? = nil,
    labelColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenLabelColonAndStatement: ExpressibleAsGarbageNodes? = nil,
    statement: ExpressibleAsStmtBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabelName = garbageBeforeLabelName?.createGarbageNodes()
    self.labelName = labelName
    self.garbageBetweenLabelNameAndLabelColon = garbageBetweenLabelNameAndLabelColon?.createGarbageNodes()
    self.labelColon = labelColon
    assert(labelColon.text == ":")
    self.garbageBetweenLabelColonAndStatement = garbageBetweenLabelColonAndStatement?.createGarbageNodes()
    self.statement = statement.createStmtBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabelName: ExpressibleAsGarbageNodes? = nil,
    labelName: String,
    garbageBetweenLabelNameAndLabelColon: ExpressibleAsGarbageNodes? = nil,
    labelColon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenLabelColonAndStatement: ExpressibleAsGarbageNodes? = nil,
    statement: ExpressibleAsStmtBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabelName: garbageBeforeLabelName,
      labelName: TokenSyntax.identifier(labelName),
      garbageBetweenLabelNameAndLabelColon: garbageBetweenLabelNameAndLabelColon,
      labelColon: labelColon,
      garbageBetweenLabelColonAndStatement: garbageBetweenLabelColonAndStatement,
      statement: statement
    )
  }

  /// Builds a `LabeledStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `LabeledStmtSyntax`.
  func buildLabeledStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> LabeledStmtSyntax {
    let result = SyntaxFactory.makeLabeledStmt(
      garbageBeforeLabelName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      labelName: labelName,
      garbageBetweenLabelNameAndLabelColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      labelColon: labelColon,
      garbageBetweenLabelColonAndStatement?.buildGarbageNodes(format: format, leadingTrivia: nil),
      statement: statement.buildStmt(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildLabeledStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsLabeledStmt`.
  public func createLabeledStmt() -> LabeledStmt {
    return self
  }

  /// `LabeledStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `LabeledStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ContinueStmt: StmtBuildable, ExpressibleAsContinueStmt {
  let garbageBeforeContinueKeyword: GarbageNodes?
  let continueKeyword: TokenSyntax
  let garbageBetweenContinueKeywordAndLabel: GarbageNodes?
  let label: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ContinueStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeContinueKeyword: 
  ///   - continueKeyword: 
  ///   - garbageBetweenContinueKeywordAndLabel: 
  ///   - label: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeContinueKeyword: ExpressibleAsGarbageNodes? = nil,
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    garbageBetweenContinueKeywordAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeContinueKeyword = garbageBeforeContinueKeyword?.createGarbageNodes()
    self.continueKeyword = continueKeyword
    assert(continueKeyword.text == "continue")
    self.garbageBetweenContinueKeywordAndLabel = garbageBetweenContinueKeywordAndLabel?.createGarbageNodes()
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeContinueKeyword: ExpressibleAsGarbageNodes? = nil,
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    garbageBetweenContinueKeywordAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeContinueKeyword: garbageBeforeContinueKeyword,
      continueKeyword: continueKeyword,
      garbageBetweenContinueKeywordAndLabel: garbageBetweenContinueKeywordAndLabel,
      label: label.map(TokenSyntax.identifier)
    )
  }

  /// Builds a `ContinueStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ContinueStmtSyntax`.
  func buildContinueStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ContinueStmtSyntax {
    let result = SyntaxFactory.makeContinueStmt(
      garbageBeforeContinueKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      continueKeyword: continueKeyword,
      garbageBetweenContinueKeywordAndLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildContinueStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsContinueStmt`.
  public func createContinueStmt() -> ContinueStmt {
    return self
  }

  /// `ContinueStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `ContinueStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct WhileStmt: StmtBuildable, ExpressibleAsWhileStmt {
  let garbageBeforeWhileKeyword: GarbageNodes?
  let whileKeyword: TokenSyntax
  let garbageBetweenWhileKeywordAndConditions: GarbageNodes?
  let conditions: ConditionElementList
  let garbageBetweenConditionsAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWhileKeyword: 
  ///   - whileKeyword: 
  ///   - garbageBetweenWhileKeywordAndConditions: 
  ///   - conditions: 
  ///   - garbageBetweenConditionsAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWhileKeyword: ExpressibleAsGarbageNodes? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    garbageBetweenWhileKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWhileKeyword = garbageBeforeWhileKeyword?.createGarbageNodes()
    self.whileKeyword = whileKeyword
    assert(whileKeyword.text == "while")
    self.garbageBetweenWhileKeywordAndConditions = garbageBetweenWhileKeywordAndConditions?.createGarbageNodes()
    self.conditions = conditions.createConditionElementList()
    self.garbageBetweenConditionsAndBody = garbageBetweenConditionsAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWhileKeyword: ExpressibleAsGarbageNodes? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    garbageBetweenWhileKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeWhileKeyword: garbageBeforeWhileKeyword,
      whileKeyword: whileKeyword,
      garbageBetweenWhileKeywordAndConditions: garbageBetweenWhileKeywordAndConditions,
      conditions: conditions,
      garbageBetweenConditionsAndBody: garbageBetweenConditionsAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `WhileStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WhileStmtSyntax`.
  func buildWhileStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WhileStmtSyntax {
    let result = SyntaxFactory.makeWhileStmt(
      garbageBeforeWhileKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whileKeyword: whileKeyword,
      garbageBetweenWhileKeywordAndConditions?.buildGarbageNodes(format: format, leadingTrivia: nil),
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      garbageBetweenConditionsAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildWhileStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsWhileStmt`.
  public func createWhileStmt() -> WhileStmt {
    return self
  }

  /// `WhileStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `WhileStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DeferStmt: StmtBuildable, ExpressibleAsDeferStmt {
  let garbageBeforeDeferKeyword: GarbageNodes?
  let deferKeyword: TokenSyntax
  let garbageBetweenDeferKeywordAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeferStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDeferKeyword: 
  ///   - deferKeyword: 
  ///   - garbageBetweenDeferKeywordAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDeferKeyword: ExpressibleAsGarbageNodes? = nil,
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    garbageBetweenDeferKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDeferKeyword = garbageBeforeDeferKeyword?.createGarbageNodes()
    self.deferKeyword = deferKeyword
    assert(deferKeyword.text == "defer")
    self.garbageBetweenDeferKeywordAndBody = garbageBetweenDeferKeywordAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDeferKeyword: ExpressibleAsGarbageNodes? = nil,
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    garbageBetweenDeferKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeDeferKeyword: garbageBeforeDeferKeyword,
      deferKeyword: deferKeyword,
      garbageBetweenDeferKeywordAndBody: garbageBetweenDeferKeywordAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `DeferStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeferStmtSyntax`.
  func buildDeferStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeferStmtSyntax {
    let result = SyntaxFactory.makeDeferStmt(
      garbageBeforeDeferKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      deferKeyword: deferKeyword,
      garbageBetweenDeferKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDeferStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsDeferStmt`.
  public func createDeferStmt() -> DeferStmt {
    return self
  }

  /// `DeferStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `DeferStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ExpressionStmt: StmtBuildable, ExpressibleAsExpressionStmt {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ExpressionStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionStmtSyntax`.
  func buildExpressionStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionStmtSyntax {
    let result = SyntaxFactory.makeExpressionStmt(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildExpressionStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsExpressionStmt`.
  public func createExpressionStmt() -> ExpressionStmt {
    return self
  }

  /// `ExpressionStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `ExpressionStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct RepeatWhileStmt: StmtBuildable, ExpressibleAsRepeatWhileStmt {
  let garbageBeforeRepeatKeyword: GarbageNodes?
  let repeatKeyword: TokenSyntax
  let garbageBetweenRepeatKeywordAndBody: GarbageNodes?
  let body: CodeBlock
  let garbageBetweenBodyAndWhileKeyword: GarbageNodes?
  let whileKeyword: TokenSyntax
  let garbageBetweenWhileKeywordAndCondition: GarbageNodes?
  let condition: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `RepeatWhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeRepeatKeyword: 
  ///   - repeatKeyword: 
  ///   - garbageBetweenRepeatKeywordAndBody: 
  ///   - body: 
  ///   - garbageBetweenBodyAndWhileKeyword: 
  ///   - whileKeyword: 
  ///   - garbageBetweenWhileKeywordAndCondition: 
  ///   - condition: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeRepeatKeyword: ExpressibleAsGarbageNodes? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    garbageBetweenRepeatKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock,
    garbageBetweenBodyAndWhileKeyword: ExpressibleAsGarbageNodes? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    garbageBetweenWhileKeywordAndCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeRepeatKeyword = garbageBeforeRepeatKeyword?.createGarbageNodes()
    self.repeatKeyword = repeatKeyword
    assert(repeatKeyword.text == "repeat")
    self.garbageBetweenRepeatKeywordAndBody = garbageBetweenRepeatKeywordAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
    self.garbageBetweenBodyAndWhileKeyword = garbageBetweenBodyAndWhileKeyword?.createGarbageNodes()
    self.whileKeyword = whileKeyword
    assert(whileKeyword.text == "while")
    self.garbageBetweenWhileKeywordAndCondition = garbageBetweenWhileKeywordAndCondition?.createGarbageNodes()
    self.condition = condition.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeRepeatKeyword: ExpressibleAsGarbageNodes? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    garbageBetweenRepeatKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenBodyAndWhileKeyword: ExpressibleAsGarbageNodes? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    garbageBetweenWhileKeywordAndCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsExprBuildable,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeRepeatKeyword: garbageBeforeRepeatKeyword,
      repeatKeyword: repeatKeyword,
      garbageBetweenRepeatKeywordAndBody: garbageBetweenRepeatKeywordAndBody,
      body: bodyBuilder(),
      garbageBetweenBodyAndWhileKeyword: garbageBetweenBodyAndWhileKeyword,
      whileKeyword: whileKeyword,
      garbageBetweenWhileKeywordAndCondition: garbageBetweenWhileKeywordAndCondition,
      condition: condition
    )
  }

  /// Builds a `RepeatWhileStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `RepeatWhileStmtSyntax`.
  func buildRepeatWhileStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> RepeatWhileStmtSyntax {
    let result = SyntaxFactory.makeRepeatWhileStmt(
      garbageBeforeRepeatKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      repeatKeyword: repeatKeyword,
      garbageBetweenRepeatKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      garbageBetweenBodyAndWhileKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whileKeyword: whileKeyword,
      garbageBetweenWhileKeywordAndCondition?.buildGarbageNodes(format: format, leadingTrivia: nil),
      condition: condition.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildRepeatWhileStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsRepeatWhileStmt`.
  public func createRepeatWhileStmt() -> RepeatWhileStmt {
    return self
  }

  /// `RepeatWhileStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `RepeatWhileStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct GuardStmt: StmtBuildable, ExpressibleAsGuardStmt {
  let garbageBeforeGuardKeyword: GarbageNodes?
  let guardKeyword: TokenSyntax
  let garbageBetweenGuardKeywordAndConditions: GarbageNodes?
  let conditions: ConditionElementList
  let garbageBetweenConditionsAndElseKeyword: GarbageNodes?
  let elseKeyword: TokenSyntax
  let garbageBetweenElseKeywordAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GuardStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeGuardKeyword: 
  ///   - guardKeyword: 
  ///   - garbageBetweenGuardKeywordAndConditions: 
  ///   - conditions: 
  ///   - garbageBetweenConditionsAndElseKeyword: 
  ///   - elseKeyword: 
  ///   - garbageBetweenElseKeywordAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeGuardKeyword: ExpressibleAsGarbageNodes? = nil,
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    garbageBetweenGuardKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    garbageBetweenElseKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeGuardKeyword = garbageBeforeGuardKeyword?.createGarbageNodes()
    self.guardKeyword = guardKeyword
    assert(guardKeyword.text == "guard")
    self.garbageBetweenGuardKeywordAndConditions = garbageBetweenGuardKeywordAndConditions?.createGarbageNodes()
    self.conditions = conditions.createConditionElementList()
    self.garbageBetweenConditionsAndElseKeyword = garbageBetweenConditionsAndElseKeyword?.createGarbageNodes()
    self.elseKeyword = elseKeyword
    assert(elseKeyword.text == "else")
    self.garbageBetweenElseKeywordAndBody = garbageBetweenElseKeywordAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeGuardKeyword: ExpressibleAsGarbageNodes? = nil,
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    garbageBetweenGuardKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    garbageBetweenElseKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeGuardKeyword: garbageBeforeGuardKeyword,
      guardKeyword: guardKeyword,
      garbageBetweenGuardKeywordAndConditions: garbageBetweenGuardKeywordAndConditions,
      conditions: conditions,
      garbageBetweenConditionsAndElseKeyword: garbageBetweenConditionsAndElseKeyword,
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndBody: garbageBetweenElseKeywordAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `GuardStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GuardStmtSyntax`.
  func buildGuardStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GuardStmtSyntax {
    let result = SyntaxFactory.makeGuardStmt(
      garbageBeforeGuardKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      guardKeyword: guardKeyword,
      garbageBetweenGuardKeywordAndConditions?.buildGarbageNodes(format: format, leadingTrivia: nil),
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      garbageBetweenConditionsAndElseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildGuardStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsGuardStmt`.
  public func createGuardStmt() -> GuardStmt {
    return self
  }

  /// `GuardStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `GuardStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct WhereClause: SyntaxBuildable, ExpressibleAsWhereClause {
  let garbageBeforeWhereKeyword: GarbageNodes?
  let whereKeyword: TokenSyntax
  let garbageBetweenWhereKeywordAndGuardResult: GarbageNodes?
  let guardResult: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WhereClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWhereKeyword: 
  ///   - whereKeyword: 
  ///   - garbageBetweenWhereKeywordAndGuardResult: 
  ///   - guardResult: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWhereKeyword: ExpressibleAsGarbageNodes? = nil,
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    garbageBetweenWhereKeywordAndGuardResult: ExpressibleAsGarbageNodes? = nil,
    guardResult: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWhereKeyword = garbageBeforeWhereKeyword?.createGarbageNodes()
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.garbageBetweenWhereKeywordAndGuardResult = garbageBetweenWhereKeywordAndGuardResult?.createGarbageNodes()
    self.guardResult = guardResult.createExprBuildable()
  }


  /// Builds a `WhereClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WhereClauseSyntax`.
  func buildWhereClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WhereClauseSyntax {
    let result = SyntaxFactory.makeWhereClause(
      garbageBeforeWhereKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereKeyword: whereKeyword,
      garbageBetweenWhereKeywordAndGuardResult?.buildGarbageNodes(format: format, leadingTrivia: nil),
      guardResult: guardResult.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildWhereClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsWhereClause`.
  public func createWhereClause() -> WhereClause {
    return self
  }

  /// `WhereClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ForInStmt: StmtBuildable, ExpressibleAsForInStmt {
  let garbageBeforeForKeyword: GarbageNodes?
  let forKeyword: TokenSyntax
  let garbageBetweenForKeywordAndTryKeyword: GarbageNodes?
  let tryKeyword: TokenSyntax?
  let garbageBetweenTryKeywordAndAwaitKeyword: GarbageNodes?
  let awaitKeyword: TokenSyntax?
  let garbageBetweenAwaitKeywordAndCaseKeyword: GarbageNodes?
  let caseKeyword: TokenSyntax?
  let garbageBetweenCaseKeywordAndPattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndTypeAnnotation: GarbageNodes?
  let typeAnnotation: TypeAnnotation?
  let garbageBetweenTypeAnnotationAndInKeyword: GarbageNodes?
  let inKeyword: TokenSyntax
  let garbageBetweenInKeywordAndSequenceExpr: GarbageNodes?
  let sequenceExpr: ExprBuildable
  let garbageBetweenSequenceExprAndWhereClause: GarbageNodes?
  let whereClause: WhereClause?
  let garbageBetweenWhereClauseAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ForInStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeForKeyword: 
  ///   - forKeyword: 
  ///   - garbageBetweenForKeywordAndTryKeyword: 
  ///   - tryKeyword: 
  ///   - garbageBetweenTryKeywordAndAwaitKeyword: 
  ///   - awaitKeyword: 
  ///   - garbageBetweenAwaitKeywordAndCaseKeyword: 
  ///   - caseKeyword: 
  ///   - garbageBetweenCaseKeywordAndPattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndTypeAnnotation: 
  ///   - typeAnnotation: 
  ///   - garbageBetweenTypeAnnotationAndInKeyword: 
  ///   - inKeyword: 
  ///   - garbageBetweenInKeywordAndSequenceExpr: 
  ///   - sequenceExpr: 
  ///   - garbageBetweenSequenceExprAndWhereClause: 
  ///   - whereClause: 
  ///   - garbageBetweenWhereClauseAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeForKeyword: ExpressibleAsGarbageNodes? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    garbageBetweenForKeywordAndTryKeyword: ExpressibleAsGarbageNodes? = nil,
    tryKeyword: TokenSyntax? = nil,
    garbageBetweenTryKeywordAndAwaitKeyword: ExpressibleAsGarbageNodes? = nil,
    awaitKeyword: TokenSyntax? = nil,
    garbageBetweenAwaitKeywordAndCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax? = nil,
    garbageBetweenCaseKeywordAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    garbageBetweenTypeAnnotationAndInKeyword: ExpressibleAsGarbageNodes? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    garbageBetweenInKeywordAndSequenceExpr: ExpressibleAsGarbageNodes? = nil,
    sequenceExpr: ExpressibleAsExprBuildable,
    garbageBetweenSequenceExprAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    garbageBetweenWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeForKeyword = garbageBeforeForKeyword?.createGarbageNodes()
    self.forKeyword = forKeyword
    assert(forKeyword.text == "for")
    self.garbageBetweenForKeywordAndTryKeyword = garbageBetweenForKeywordAndTryKeyword?.createGarbageNodes()
    self.tryKeyword = tryKeyword
    assert(tryKeyword == nil || tryKeyword!.text == "try")
    self.garbageBetweenTryKeywordAndAwaitKeyword = garbageBetweenTryKeywordAndAwaitKeyword?.createGarbageNodes()
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword == nil || awaitKeyword!.text == "await")
    self.garbageBetweenAwaitKeywordAndCaseKeyword = garbageBetweenAwaitKeywordAndCaseKeyword?.createGarbageNodes()
    self.caseKeyword = caseKeyword
    assert(caseKeyword == nil || caseKeyword!.text == "case")
    self.garbageBetweenCaseKeywordAndPattern = garbageBetweenCaseKeywordAndPattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndTypeAnnotation = garbageBetweenPatternAndTypeAnnotation?.createGarbageNodes()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.garbageBetweenTypeAnnotationAndInKeyword = garbageBetweenTypeAnnotationAndInKeyword?.createGarbageNodes()
    self.inKeyword = inKeyword
    assert(inKeyword.text == "in")
    self.garbageBetweenInKeywordAndSequenceExpr = garbageBetweenInKeywordAndSequenceExpr?.createGarbageNodes()
    self.sequenceExpr = sequenceExpr.createExprBuildable()
    self.garbageBetweenSequenceExprAndWhereClause = garbageBetweenSequenceExprAndWhereClause?.createGarbageNodes()
    self.whereClause = whereClause?.createWhereClause()
    self.garbageBetweenWhereClauseAndBody = garbageBetweenWhereClauseAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeForKeyword: ExpressibleAsGarbageNodes? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    garbageBetweenForKeywordAndTryKeyword: ExpressibleAsGarbageNodes? = nil,
    tryKeyword: TokenSyntax? = nil,
    garbageBetweenTryKeywordAndAwaitKeyword: ExpressibleAsGarbageNodes? = nil,
    awaitKeyword: String?,
    garbageBetweenAwaitKeywordAndCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax? = nil,
    garbageBetweenCaseKeywordAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    garbageBetweenTypeAnnotationAndInKeyword: ExpressibleAsGarbageNodes? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    garbageBetweenInKeywordAndSequenceExpr: ExpressibleAsGarbageNodes? = nil,
    sequenceExpr: ExpressibleAsExprBuildable,
    garbageBetweenSequenceExprAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    garbageBetweenWhereClauseAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeForKeyword: garbageBeforeForKeyword,
      forKeyword: forKeyword,
      garbageBetweenForKeywordAndTryKeyword: garbageBetweenForKeywordAndTryKeyword,
      tryKeyword: tryKeyword,
      garbageBetweenTryKeywordAndAwaitKeyword: garbageBetweenTryKeywordAndAwaitKeyword,
      awaitKeyword: awaitKeyword.map(TokenSyntax.identifier),
      garbageBetweenAwaitKeywordAndCaseKeyword: garbageBetweenAwaitKeywordAndCaseKeyword,
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndPattern: garbageBetweenCaseKeywordAndPattern,
      pattern: pattern,
      garbageBetweenPatternAndTypeAnnotation: garbageBetweenPatternAndTypeAnnotation,
      typeAnnotation: typeAnnotation,
      garbageBetweenTypeAnnotationAndInKeyword: garbageBetweenTypeAnnotationAndInKeyword,
      inKeyword: inKeyword,
      garbageBetweenInKeywordAndSequenceExpr: garbageBetweenInKeywordAndSequenceExpr,
      sequenceExpr: sequenceExpr,
      garbageBetweenSequenceExprAndWhereClause: garbageBetweenSequenceExprAndWhereClause,
      whereClause: whereClause,
      garbageBetweenWhereClauseAndBody: garbageBetweenWhereClauseAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `ForInStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ForInStmtSyntax`.
  func buildForInStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ForInStmtSyntax {
    let result = SyntaxFactory.makeForInStmt(
      garbageBeforeForKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      forKeyword: forKeyword,
      garbageBetweenForKeywordAndTryKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      tryKeyword: tryKeyword,
      garbageBetweenTryKeywordAndAwaitKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      awaitKeyword: awaitKeyword,
      garbageBetweenAwaitKeywordAndCaseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndPattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndTypeAnnotation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      garbageBetweenTypeAnnotationAndInKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inKeyword: inKeyword,
      garbageBetweenInKeywordAndSequenceExpr?.buildGarbageNodes(format: format, leadingTrivia: nil),
      sequenceExpr: sequenceExpr.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenSequenceExprAndWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenWhereClauseAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildForInStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsForInStmt`.
  public func createForInStmt() -> ForInStmt {
    return self
  }

  /// `ForInStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `ForInStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct SwitchStmt: StmtBuildable, ExpressibleAsSwitchStmt {
  let garbageBeforeSwitchKeyword: GarbageNodes?
  let switchKeyword: TokenSyntax
  let garbageBetweenSwitchKeywordAndExpression: GarbageNodes?
  let expression: ExprBuildable
  let garbageBetweenExpressionAndLeftBrace: GarbageNodes?
  let leftBrace: TokenSyntax
  let garbageBetweenLeftBraceAndCases: GarbageNodes?
  let cases: SwitchCaseList
  let garbageBetweenCasesAndRightBrace: GarbageNodes?
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSwitchKeyword: 
  ///   - switchKeyword: 
  ///   - garbageBetweenSwitchKeywordAndExpression: 
  ///   - expression: 
  ///   - garbageBetweenExpressionAndLeftBrace: 
  ///   - leftBrace: 
  ///   - garbageBetweenLeftBraceAndCases: 
  ///   - cases: 
  ///   - garbageBetweenCasesAndRightBrace: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSwitchKeyword: ExpressibleAsGarbageNodes? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    garbageBetweenSwitchKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndCases: ExpressibleAsGarbageNodes? = nil,
    cases: ExpressibleAsSwitchCaseList,
    garbageBetweenCasesAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSwitchKeyword = garbageBeforeSwitchKeyword?.createGarbageNodes()
    self.switchKeyword = switchKeyword
    assert(switchKeyword.text == "switch")
    self.garbageBetweenSwitchKeywordAndExpression = garbageBetweenSwitchKeywordAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
    self.garbageBetweenExpressionAndLeftBrace = garbageBetweenExpressionAndLeftBrace?.createGarbageNodes()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.garbageBetweenLeftBraceAndCases = garbageBetweenLeftBraceAndCases?.createGarbageNodes()
    self.cases = cases.createSwitchCaseList()
    self.garbageBetweenCasesAndRightBrace = garbageBetweenCasesAndRightBrace?.createGarbageNodes()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSwitchKeyword: ExpressibleAsGarbageNodes? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    garbageBetweenSwitchKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable,
    garbageBetweenExpressionAndLeftBrace: ExpressibleAsGarbageNodes? = nil,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    garbageBetweenLeftBraceAndCases: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenCasesAndRightBrace: ExpressibleAsGarbageNodes? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> ExpressibleAsSwitchCaseList = { SwitchCaseList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeSwitchKeyword: garbageBeforeSwitchKeyword,
      switchKeyword: switchKeyword,
      garbageBetweenSwitchKeywordAndExpression: garbageBetweenSwitchKeywordAndExpression,
      expression: expression,
      garbageBetweenExpressionAndLeftBrace: garbageBetweenExpressionAndLeftBrace,
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndCases: garbageBetweenLeftBraceAndCases,
      cases: casesBuilder(),
      garbageBetweenCasesAndRightBrace: garbageBetweenCasesAndRightBrace,
      rightBrace: rightBrace
    )
  }

  /// Builds a `SwitchStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchStmtSyntax`.
  func buildSwitchStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchStmtSyntax {
    let result = SyntaxFactory.makeSwitchStmt(
      garbageBeforeSwitchKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      switchKeyword: switchKeyword,
      garbageBetweenSwitchKeywordAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenExpressionAndLeftBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      garbageBetweenLeftBraceAndCases?.buildGarbageNodes(format: format, leadingTrivia: nil),
      cases: cases.buildSwitchCaseList(format: format, leadingTrivia: nil),
      garbageBetweenCasesAndRightBrace?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildSwitchStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsSwitchStmt`.
  public func createSwitchStmt() -> SwitchStmt {
    return self
  }

  /// `SwitchStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `SwitchStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DoStmt: StmtBuildable, ExpressibleAsDoStmt {
  let garbageBeforeDoKeyword: GarbageNodes?
  let doKeyword: TokenSyntax
  let garbageBetweenDoKeywordAndBody: GarbageNodes?
  let body: CodeBlock
  let garbageBetweenBodyAndCatchClauses: GarbageNodes?
  let catchClauses: CatchClauseList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DoStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDoKeyword: 
  ///   - doKeyword: 
  ///   - garbageBetweenDoKeywordAndBody: 
  ///   - body: 
  ///   - garbageBetweenBodyAndCatchClauses: 
  ///   - catchClauses: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDoKeyword: ExpressibleAsGarbageNodes? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    garbageBetweenDoKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock,
    garbageBetweenBodyAndCatchClauses: ExpressibleAsGarbageNodes? = nil,
    catchClauses: ExpressibleAsCatchClauseList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDoKeyword = garbageBeforeDoKeyword?.createGarbageNodes()
    self.doKeyword = doKeyword
    assert(doKeyword.text == "do")
    self.garbageBetweenDoKeywordAndBody = garbageBetweenDoKeywordAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
    self.garbageBetweenBodyAndCatchClauses = garbageBetweenBodyAndCatchClauses?.createGarbageNodes()
    self.catchClauses = catchClauses?.createCatchClauseList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDoKeyword: ExpressibleAsGarbageNodes? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    garbageBetweenDoKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenBodyAndCatchClauses: ExpressibleAsGarbageNodes? = nil,
    catchClauses: ExpressibleAsCatchClauseList? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeDoKeyword: garbageBeforeDoKeyword,
      doKeyword: doKeyword,
      garbageBetweenDoKeywordAndBody: garbageBetweenDoKeywordAndBody,
      body: bodyBuilder(),
      garbageBetweenBodyAndCatchClauses: garbageBetweenBodyAndCatchClauses,
      catchClauses: catchClauses
    )
  }

  /// Builds a `DoStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DoStmtSyntax`.
  func buildDoStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DoStmtSyntax {
    let result = SyntaxFactory.makeDoStmt(
      garbageBeforeDoKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      doKeyword: doKeyword,
      garbageBetweenDoKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      garbageBetweenBodyAndCatchClauses?.buildGarbageNodes(format: format, leadingTrivia: nil),
      catchClauses: catchClauses?.buildCatchClauseList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDoStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsDoStmt`.
  public func createDoStmt() -> DoStmt {
    return self
  }

  /// `DoStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `DoStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ReturnStmt: StmtBuildable, ExpressibleAsReturnStmt {
  let garbageBeforeReturnKeyword: GarbageNodes?
  let returnKeyword: TokenSyntax
  let garbageBetweenReturnKeywordAndExpression: GarbageNodes?
  let expression: ExprBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ReturnStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeReturnKeyword: 
  ///   - returnKeyword: 
  ///   - garbageBetweenReturnKeywordAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeReturnKeyword: ExpressibleAsGarbageNodes? = nil,
    returnKeyword: TokenSyntax = TokenSyntax.`return`,
    garbageBetweenReturnKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeReturnKeyword = garbageBeforeReturnKeyword?.createGarbageNodes()
    self.returnKeyword = returnKeyword
    assert(returnKeyword.text == "return")
    self.garbageBetweenReturnKeywordAndExpression = garbageBetweenReturnKeywordAndExpression?.createGarbageNodes()
    self.expression = expression?.createExprBuildable()
  }


  /// Builds a `ReturnStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ReturnStmtSyntax`.
  func buildReturnStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ReturnStmtSyntax {
    let result = SyntaxFactory.makeReturnStmt(
      garbageBeforeReturnKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      returnKeyword: returnKeyword,
      garbageBetweenReturnKeywordAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression?.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildReturnStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsReturnStmt`.
  public func createReturnStmt() -> ReturnStmt {
    return self
  }

  /// `ReturnStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `ReturnStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct YieldStmt: StmtBuildable, ExpressibleAsYieldStmt {
  let garbageBeforeYieldKeyword: GarbageNodes?
  let yieldKeyword: TokenSyntax
  let garbageBetweenYieldKeywordAndYields: GarbageNodes?
  let yields: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `YieldStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeYieldKeyword: 
  ///   - yieldKeyword: 
  ///   - garbageBetweenYieldKeywordAndYields: 
  ///   - yields: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeYieldKeyword: ExpressibleAsGarbageNodes? = nil,
    yieldKeyword: TokenSyntax = TokenSyntax.`yield`,
    garbageBetweenYieldKeywordAndYields: ExpressibleAsGarbageNodes? = nil,
    yields: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeYieldKeyword = garbageBeforeYieldKeyword?.createGarbageNodes()
    self.yieldKeyword = yieldKeyword
    assert(yieldKeyword.text == "yield")
    self.garbageBetweenYieldKeywordAndYields = garbageBetweenYieldKeywordAndYields?.createGarbageNodes()
    self.yields = yields.createSyntaxBuildable()
  }


  /// Builds a `YieldStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `YieldStmtSyntax`.
  func buildYieldStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> YieldStmtSyntax {
    let result = SyntaxFactory.makeYieldStmt(
      garbageBeforeYieldKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      yieldKeyword: yieldKeyword,
      garbageBetweenYieldKeywordAndYields?.buildGarbageNodes(format: format, leadingTrivia: nil),
      yields: yields.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildYieldStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsYieldStmt`.
  public func createYieldStmt() -> YieldStmt {
    return self
  }

  /// `YieldStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `YieldStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct YieldList: SyntaxBuildable, ExpressibleAsYieldList {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndElementList: GarbageNodes?
  let elementList: ExprList
  let garbageBetweenElementListAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?
  let garbageBetweenTrailingCommaAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `YieldList` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndElementList: 
  ///   - elementList: 
  ///   - garbageBetweenElementListAndTrailingComma: 
  ///   - trailingComma: 
  ///   - garbageBetweenTrailingCommaAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElementList: ExpressibleAsGarbageNodes? = nil,
    elementList: ExpressibleAsExprList,
    garbageBetweenElementListAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil,
    garbageBetweenTrailingCommaAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndElementList = garbageBetweenLeftParenAndElementList?.createGarbageNodes()
    self.elementList = elementList.createExprList()
    self.garbageBetweenElementListAndTrailingComma = garbageBetweenElementListAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
    self.garbageBetweenTrailingCommaAndRightParen = garbageBetweenTrailingCommaAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElementList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenElementListAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil,
    garbageBetweenTrailingCommaAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @ExprListBuilder elementListBuilder: () -> ExpressibleAsExprList = { ExprList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndElementList: garbageBetweenLeftParenAndElementList,
      elementList: elementListBuilder(),
      garbageBetweenElementListAndTrailingComma: garbageBetweenElementListAndTrailingComma,
      trailingComma: trailingComma,
      garbageBetweenTrailingCommaAndRightParen: garbageBetweenTrailingCommaAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `YieldListSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `YieldListSyntax`.
  func buildYieldList(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> YieldListSyntax {
    let result = SyntaxFactory.makeYieldList(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndElementList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elementList: elementList.buildExprList(format: format, leadingTrivia: nil),
      garbageBetweenElementListAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma,
      garbageBetweenTrailingCommaAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildYieldList(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsYieldList`.
  public func createYieldList() -> YieldList {
    return self
  }

  /// `YieldList` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct FallthroughStmt: StmtBuildable, ExpressibleAsFallthroughStmt {
  let garbageBeforeFallthroughKeyword: GarbageNodes?
  let fallthroughKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FallthroughStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeFallthroughKeyword: 
  ///   - fallthroughKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeFallthroughKeyword: ExpressibleAsGarbageNodes? = nil,
    fallthroughKeyword: TokenSyntax = TokenSyntax.`fallthrough`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeFallthroughKeyword = garbageBeforeFallthroughKeyword?.createGarbageNodes()
    self.fallthroughKeyword = fallthroughKeyword
    assert(fallthroughKeyword.text == "fallthrough")
  }


  /// Builds a `FallthroughStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FallthroughStmtSyntax`.
  func buildFallthroughStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FallthroughStmtSyntax {
    let result = SyntaxFactory.makeFallthroughStmt(
      garbageBeforeFallthroughKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      fallthroughKeyword: fallthroughKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildFallthroughStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsFallthroughStmt`.
  public func createFallthroughStmt() -> FallthroughStmt {
    return self
  }

  /// `FallthroughStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `FallthroughStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct BreakStmt: StmtBuildable, ExpressibleAsBreakStmt {
  let garbageBeforeBreakKeyword: GarbageNodes?
  let breakKeyword: TokenSyntax
  let garbageBetweenBreakKeywordAndLabel: GarbageNodes?
  let label: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BreakStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBreakKeyword: 
  ///   - breakKeyword: 
  ///   - garbageBetweenBreakKeywordAndLabel: 
  ///   - label: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBreakKeyword: ExpressibleAsGarbageNodes? = nil,
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    garbageBetweenBreakKeywordAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBreakKeyword = garbageBeforeBreakKeyword?.createGarbageNodes()
    self.breakKeyword = breakKeyword
    assert(breakKeyword.text == "break")
    self.garbageBetweenBreakKeywordAndLabel = garbageBetweenBreakKeywordAndLabel?.createGarbageNodes()
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBreakKeyword: ExpressibleAsGarbageNodes? = nil,
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    garbageBetweenBreakKeywordAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeBreakKeyword: garbageBeforeBreakKeyword,
      breakKeyword: breakKeyword,
      garbageBetweenBreakKeywordAndLabel: garbageBetweenBreakKeywordAndLabel,
      label: label.map(TokenSyntax.identifier)
    )
  }

  /// Builds a `BreakStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BreakStmtSyntax`.
  func buildBreakStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BreakStmtSyntax {
    let result = SyntaxFactory.makeBreakStmt(
      garbageBeforeBreakKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      breakKeyword: breakKeyword,
      garbageBetweenBreakKeywordAndLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildBreakStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsBreakStmt`.
  public func createBreakStmt() -> BreakStmt {
    return self
  }

  /// `BreakStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `BreakStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ConditionElement: SyntaxBuildable, ExpressibleAsConditionElement, HasTrailingComma {
  let garbageBeforeCondition: GarbageNodes?
  let condition: SyntaxBuildable
  let garbageBetweenConditionAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConditionElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCondition: 
  ///   - condition: 
  ///   - garbageBetweenConditionAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsSyntaxBuildable,
    garbageBetweenConditionAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCondition = garbageBeforeCondition?.createGarbageNodes()
    self.condition = condition.createSyntaxBuildable()
    self.garbageBetweenConditionAndTrailingComma = garbageBetweenConditionAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ConditionElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConditionElementSyntax`.
  func buildConditionElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConditionElementSyntax {
    let result = SyntaxFactory.makeConditionElement(
      garbageBeforeCondition?.buildGarbageNodes(format: format, leadingTrivia: nil),
      condition: condition.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenConditionAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildConditionElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsConditionElement`.
  public func createConditionElement() -> ConditionElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeCondition: garbageBeforeCondition,
        condition: condition,
        garbageBetweenConditionAndTrailingComma: garbageBetweenConditionAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `ConditionElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct AvailabilityCondition: SyntaxBuildable, ExpressibleAsAvailabilityCondition {
  let garbageBeforePoundAvailableKeyword: GarbageNodes?
  let poundAvailableKeyword: TokenSyntax
  let garbageBetweenPoundAvailableKeywordAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndAvailabilitySpec: GarbageNodes?
  let availabilitySpec: AvailabilitySpecList
  let garbageBetweenAvailabilitySpecAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundAvailableKeyword: 
  ///   - poundAvailableKeyword: 
  ///   - garbageBetweenPoundAvailableKeywordAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndAvailabilitySpec: 
  ///   - availabilitySpec: 
  ///   - garbageBetweenAvailabilitySpecAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundAvailableKeyword: ExpressibleAsGarbageNodes? = nil,
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    garbageBetweenPoundAvailableKeywordAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndAvailabilitySpec: ExpressibleAsGarbageNodes? = nil,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    garbageBetweenAvailabilitySpecAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundAvailableKeyword = garbageBeforePoundAvailableKeyword?.createGarbageNodes()
    self.poundAvailableKeyword = poundAvailableKeyword
    assert(poundAvailableKeyword.text == "#available")
    self.garbageBetweenPoundAvailableKeywordAndLeftParen = garbageBetweenPoundAvailableKeywordAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndAvailabilitySpec = garbageBetweenLeftParenAndAvailabilitySpec?.createGarbageNodes()
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.garbageBetweenAvailabilitySpecAndRightParen = garbageBetweenAvailabilitySpecAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `AvailabilityConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityConditionSyntax`.
  func buildAvailabilityCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityConditionSyntax {
    let result = SyntaxFactory.makeAvailabilityCondition(
      garbageBeforePoundAvailableKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundAvailableKeyword: poundAvailableKeyword,
      garbageBetweenPoundAvailableKeywordAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndAvailabilitySpec?.buildGarbageNodes(format: format, leadingTrivia: nil),
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      garbageBetweenAvailabilitySpecAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityCondition(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAvailabilityCondition`.
  public func createAvailabilityCondition() -> AvailabilityCondition {
    return self
  }

  /// `AvailabilityCondition` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct MatchingPatternCondition: SyntaxBuildable, ExpressibleAsMatchingPatternCondition {
  let garbageBeforeCaseKeyword: GarbageNodes?
  let caseKeyword: TokenSyntax
  let garbageBetweenCaseKeywordAndPattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndTypeAnnotation: GarbageNodes?
  let typeAnnotation: TypeAnnotation?
  let garbageBetweenTypeAnnotationAndInitializer: GarbageNodes?
  let initializer: InitializerClause

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MatchingPatternCondition` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCaseKeyword: 
  ///   - caseKeyword: 
  ///   - garbageBetweenCaseKeywordAndPattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndTypeAnnotation: 
  ///   - typeAnnotation: 
  ///   - garbageBetweenTypeAnnotationAndInitializer: 
  ///   - initializer: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    garbageBetweenCaseKeywordAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    garbageBetweenTypeAnnotationAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsInitializerClause
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCaseKeyword = garbageBeforeCaseKeyword?.createGarbageNodes()
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.garbageBetweenCaseKeywordAndPattern = garbageBetweenCaseKeywordAndPattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndTypeAnnotation = garbageBetweenPatternAndTypeAnnotation?.createGarbageNodes()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.garbageBetweenTypeAnnotationAndInitializer = garbageBetweenTypeAnnotationAndInitializer?.createGarbageNodes()
    self.initializer = initializer.createInitializerClause()
  }


  /// Builds a `MatchingPatternConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MatchingPatternConditionSyntax`.
  func buildMatchingPatternCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MatchingPatternConditionSyntax {
    let result = SyntaxFactory.makeMatchingPatternCondition(
      garbageBeforeCaseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndPattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndTypeAnnotation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      garbageBetweenTypeAnnotationAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMatchingPatternCondition(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsMatchingPatternCondition`.
  public func createMatchingPatternCondition() -> MatchingPatternCondition {
    return self
  }

  /// `MatchingPatternCondition` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct OptionalBindingCondition: SyntaxBuildable, ExpressibleAsOptionalBindingCondition {
  let garbageBeforeLetOrVarKeyword: GarbageNodes?
  let letOrVarKeyword: TokenSyntax
  let garbageBetweenLetOrVarKeywordAndPattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndTypeAnnotation: GarbageNodes?
  let typeAnnotation: TypeAnnotation?
  let garbageBetweenTypeAnnotationAndInitializer: GarbageNodes?
  let initializer: InitializerClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalBindingCondition` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLetOrVarKeyword: 
  ///   - letOrVarKeyword: 
  ///   - garbageBetweenLetOrVarKeywordAndPattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndTypeAnnotation: 
  ///   - typeAnnotation: 
  ///   - garbageBetweenTypeAnnotationAndInitializer: 
  ///   - initializer: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLetOrVarKeyword: ExpressibleAsGarbageNodes? = nil,
    letOrVarKeyword: TokenSyntax,
    garbageBetweenLetOrVarKeywordAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    garbageBetweenTypeAnnotationAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsInitializerClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLetOrVarKeyword = garbageBeforeLetOrVarKeyword?.createGarbageNodes()
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.garbageBetweenLetOrVarKeywordAndPattern = garbageBetweenLetOrVarKeywordAndPattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndTypeAnnotation = garbageBetweenPatternAndTypeAnnotation?.createGarbageNodes()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.garbageBetweenTypeAnnotationAndInitializer = garbageBetweenTypeAnnotationAndInitializer?.createGarbageNodes()
    self.initializer = initializer?.createInitializerClause()
  }


  /// Builds a `OptionalBindingConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalBindingConditionSyntax`.
  func buildOptionalBindingCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalBindingConditionSyntax {
    let result = SyntaxFactory.makeOptionalBindingCondition(
      garbageBeforeLetOrVarKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      letOrVarKeyword: letOrVarKeyword,
      garbageBetweenLetOrVarKeywordAndPattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndTypeAnnotation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      garbageBetweenTypeAnnotationAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildOptionalBindingCondition(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsOptionalBindingCondition`.
  public func createOptionalBindingCondition() -> OptionalBindingCondition {
    return self
  }

  /// `OptionalBindingCondition` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct UnavailabilityCondition: SyntaxBuildable, ExpressibleAsUnavailabilityCondition {
  let garbageBeforePoundUnavailableKeyword: GarbageNodes?
  let poundUnavailableKeyword: TokenSyntax
  let garbageBetweenPoundUnavailableKeywordAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndAvailabilitySpec: GarbageNodes?
  let availabilitySpec: AvailabilitySpecList
  let garbageBetweenAvailabilitySpecAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `UnavailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundUnavailableKeyword: 
  ///   - poundUnavailableKeyword: 
  ///   - garbageBetweenPoundUnavailableKeywordAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndAvailabilitySpec: 
  ///   - availabilitySpec: 
  ///   - garbageBetweenAvailabilitySpecAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundUnavailableKeyword: ExpressibleAsGarbageNodes? = nil,
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    garbageBetweenPoundUnavailableKeywordAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndAvailabilitySpec: ExpressibleAsGarbageNodes? = nil,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    garbageBetweenAvailabilitySpecAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundUnavailableKeyword = garbageBeforePoundUnavailableKeyword?.createGarbageNodes()
    self.poundUnavailableKeyword = poundUnavailableKeyword
    assert(poundUnavailableKeyword.text == "#unavailable")
    self.garbageBetweenPoundUnavailableKeywordAndLeftParen = garbageBetweenPoundUnavailableKeywordAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndAvailabilitySpec = garbageBetweenLeftParenAndAvailabilitySpec?.createGarbageNodes()
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.garbageBetweenAvailabilitySpecAndRightParen = garbageBetweenAvailabilitySpecAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `UnavailabilityConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `UnavailabilityConditionSyntax`.
  func buildUnavailabilityCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> UnavailabilityConditionSyntax {
    let result = SyntaxFactory.makeUnavailabilityCondition(
      garbageBeforePoundUnavailableKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundUnavailableKeyword: poundUnavailableKeyword,
      garbageBetweenPoundUnavailableKeywordAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndAvailabilitySpec?.buildGarbageNodes(format: format, leadingTrivia: nil),
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      garbageBetweenAvailabilitySpecAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildUnavailabilityCondition(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsUnavailabilityCondition`.
  public func createUnavailabilityCondition() -> UnavailabilityCondition {
    return self
  }

  /// `UnavailabilityCondition` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DeclarationStmt: StmtBuildable, ExpressibleAsDeclarationStmt {
  let garbageBeforeDeclaration: GarbageNodes?
  let declaration: DeclBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclarationStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDeclaration: 
  ///   - declaration: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDeclaration: ExpressibleAsGarbageNodes? = nil,
    declaration: ExpressibleAsDeclBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDeclaration = garbageBeforeDeclaration?.createGarbageNodes()
    self.declaration = declaration.createDeclBuildable()
  }


  /// Builds a `DeclarationStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclarationStmtSyntax`.
  func buildDeclarationStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclarationStmtSyntax {
    let result = SyntaxFactory.makeDeclarationStmt(
      garbageBeforeDeclaration?.buildGarbageNodes(format: format, leadingTrivia: nil),
      declaration: declaration.buildDecl(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDeclarationStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsDeclarationStmt`.
  public func createDeclarationStmt() -> DeclarationStmt {
    return self
  }

  /// `DeclarationStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `DeclarationStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ThrowStmt: StmtBuildable, ExpressibleAsThrowStmt {
  let garbageBeforeThrowKeyword: GarbageNodes?
  let throwKeyword: TokenSyntax
  let garbageBetweenThrowKeywordAndExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ThrowStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeThrowKeyword: 
  ///   - throwKeyword: 
  ///   - garbageBetweenThrowKeywordAndExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeThrowKeyword: ExpressibleAsGarbageNodes? = nil,
    throwKeyword: TokenSyntax = TokenSyntax.`throw`,
    garbageBetweenThrowKeywordAndExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeThrowKeyword = garbageBeforeThrowKeyword?.createGarbageNodes()
    self.throwKeyword = throwKeyword
    assert(throwKeyword.text == "throw")
    self.garbageBetweenThrowKeywordAndExpression = garbageBetweenThrowKeywordAndExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ThrowStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ThrowStmtSyntax`.
  func buildThrowStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ThrowStmtSyntax {
    let result = SyntaxFactory.makeThrowStmt(
      garbageBeforeThrowKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwKeyword: throwKeyword,
      garbageBetweenThrowKeywordAndExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildThrowStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsThrowStmt`.
  public func createThrowStmt() -> ThrowStmt {
    return self
  }

  /// `ThrowStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `ThrowStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct IfStmt: StmtBuildable, ExpressibleAsIfStmt {
  let garbageBeforeIfKeyword: GarbageNodes?
  let ifKeyword: TokenSyntax
  let garbageBetweenIfKeywordAndConditions: GarbageNodes?
  let conditions: ConditionElementList
  let garbageBetweenConditionsAndBody: GarbageNodes?
  let body: CodeBlock
  let garbageBetweenBodyAndElseKeyword: GarbageNodes?
  let elseKeyword: TokenSyntax?
  let garbageBetweenElseKeywordAndElseBody: GarbageNodes?
  let elseBody: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIfKeyword: 
  ///   - ifKeyword: 
  ///   - garbageBetweenIfKeywordAndConditions: 
  ///   - conditions: 
  ///   - garbageBetweenConditionsAndBody: 
  ///   - body: 
  ///   - garbageBetweenBodyAndElseKeyword: 
  ///   - elseKeyword: 
  ///   - garbageBetweenElseKeywordAndElseBody: 
  ///   - elseBody: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIfKeyword: ExpressibleAsGarbageNodes? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    garbageBetweenIfKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock,
    garbageBetweenBodyAndElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax? = nil,
    garbageBetweenElseKeywordAndElseBody: ExpressibleAsGarbageNodes? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIfKeyword = garbageBeforeIfKeyword?.createGarbageNodes()
    self.ifKeyword = ifKeyword
    assert(ifKeyword.text == "if")
    self.garbageBetweenIfKeywordAndConditions = garbageBetweenIfKeywordAndConditions?.createGarbageNodes()
    self.conditions = conditions.createConditionElementList()
    self.garbageBetweenConditionsAndBody = garbageBetweenConditionsAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
    self.garbageBetweenBodyAndElseKeyword = garbageBetweenBodyAndElseKeyword?.createGarbageNodes()
    self.elseKeyword = elseKeyword
    assert(elseKeyword == nil || elseKeyword!.text == "else")
    self.garbageBetweenElseKeywordAndElseBody = garbageBetweenElseKeywordAndElseBody?.createGarbageNodes()
    self.elseBody = elseBody?.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIfKeyword: ExpressibleAsGarbageNodes? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    garbageBetweenIfKeywordAndConditions: ExpressibleAsGarbageNodes? = nil,
    conditions: ExpressibleAsConditionElementList,
    garbageBetweenConditionsAndBody: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenBodyAndElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax? = nil,
    garbageBetweenElseKeywordAndElseBody: ExpressibleAsGarbageNodes? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeIfKeyword: garbageBeforeIfKeyword,
      ifKeyword: ifKeyword,
      garbageBetweenIfKeywordAndConditions: garbageBetweenIfKeywordAndConditions,
      conditions: conditions,
      garbageBetweenConditionsAndBody: garbageBetweenConditionsAndBody,
      body: bodyBuilder(),
      garbageBetweenBodyAndElseKeyword: garbageBetweenBodyAndElseKeyword,
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndElseBody: garbageBetweenElseKeywordAndElseBody,
      elseBody: elseBody
    )
  }

  /// Builds a `IfStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfStmtSyntax`.
  func buildIfStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfStmtSyntax {
    let result = SyntaxFactory.makeIfStmt(
      garbageBeforeIfKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ifKeyword: ifKeyword,
      garbageBetweenIfKeywordAndConditions?.buildGarbageNodes(format: format, leadingTrivia: nil),
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      garbageBetweenConditionsAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      garbageBetweenBodyAndElseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndElseBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elseBody: elseBody?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildIfStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsIfStmt`.
  public func createIfStmt() -> IfStmt {
    return self
  }

  /// `IfStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `IfStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ElseIfContinuation: SyntaxBuildable, ExpressibleAsElseIfContinuation {
  let garbageBeforeIfStatement: GarbageNodes?
  let ifStatement: IfStmt

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ElseIfContinuation` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIfStatement: 
  ///   - ifStatement: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIfStatement: ExpressibleAsGarbageNodes? = nil,
    ifStatement: ExpressibleAsIfStmt
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIfStatement = garbageBeforeIfStatement?.createGarbageNodes()
    self.ifStatement = ifStatement.createIfStmt()
  }


  /// Builds a `ElseIfContinuationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ElseIfContinuationSyntax`.
  func buildElseIfContinuation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ElseIfContinuationSyntax {
    let result = SyntaxFactory.makeElseIfContinuation(
      garbageBeforeIfStatement?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ifStatement: ifStatement.buildIfStmt(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildElseIfContinuation(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsElseIfContinuation`.
  public func createElseIfContinuation() -> ElseIfContinuation {
    return self
  }

  /// `ElseIfContinuation` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ElseBlock: SyntaxBuildable, ExpressibleAsElseBlock {
  let garbageBeforeElseKeyword: GarbageNodes?
  let elseKeyword: TokenSyntax
  let garbageBetweenElseKeywordAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ElseBlock` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeElseKeyword: 
  ///   - elseKeyword: 
  ///   - garbageBetweenElseKeywordAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    garbageBetweenElseKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeElseKeyword = garbageBeforeElseKeyword?.createGarbageNodes()
    self.elseKeyword = elseKeyword
    assert(elseKeyword.text == "else")
    self.garbageBetweenElseKeywordAndBody = garbageBetweenElseKeywordAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeElseKeyword: ExpressibleAsGarbageNodes? = nil,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    garbageBetweenElseKeywordAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeElseKeyword: garbageBeforeElseKeyword,
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndBody: garbageBetweenElseKeywordAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `ElseBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ElseBlockSyntax`.
  func buildElseBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ElseBlockSyntax {
    let result = SyntaxFactory.makeElseBlock(
      garbageBeforeElseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      garbageBetweenElseKeywordAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildElseBlock(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsElseBlock`.
  public func createElseBlock() -> ElseBlock {
    return self
  }

  /// `ElseBlock` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SwitchCase: SyntaxBuildable, ExpressibleAsSwitchCase {
  let garbageBeforeUnknownAttr: GarbageNodes?
  let unknownAttr: Attribute?
  let garbageBetweenUnknownAttrAndLabel: GarbageNodes?
  let label: SyntaxBuildable
  let garbageBetweenLabelAndStatements: GarbageNodes?
  let statements: CodeBlockItemList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchCase` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeUnknownAttr: 
  ///   - unknownAttr: 
  ///   - garbageBetweenUnknownAttrAndLabel: 
  ///   - label: 
  ///   - garbageBetweenLabelAndStatements: 
  ///   - statements: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeUnknownAttr: ExpressibleAsGarbageNodes? = nil,
    unknownAttr: ExpressibleAsAttribute? = nil,
    garbageBetweenUnknownAttrAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: ExpressibleAsSyntaxBuildable,
    garbageBetweenLabelAndStatements: ExpressibleAsGarbageNodes? = nil,
    statements: ExpressibleAsCodeBlockItemList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeUnknownAttr = garbageBeforeUnknownAttr?.createGarbageNodes()
    self.unknownAttr = unknownAttr?.createAttribute()
    self.garbageBetweenUnknownAttrAndLabel = garbageBetweenUnknownAttrAndLabel?.createGarbageNodes()
    self.label = label.createSyntaxBuildable()
    self.garbageBetweenLabelAndStatements = garbageBetweenLabelAndStatements?.createGarbageNodes()
    self.statements = statements.createCodeBlockItemList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeUnknownAttr: ExpressibleAsGarbageNodes? = nil,
    unknownAttr: ExpressibleAsAttribute? = nil,
    garbageBetweenUnknownAttrAndLabel: ExpressibleAsGarbageNodes? = nil,
    label: ExpressibleAsSyntaxBuildable,
    garbageBetweenLabelAndStatements: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeUnknownAttr: garbageBeforeUnknownAttr,
      unknownAttr: unknownAttr,
      garbageBetweenUnknownAttrAndLabel: garbageBetweenUnknownAttrAndLabel,
      label: label,
      garbageBetweenLabelAndStatements: garbageBetweenLabelAndStatements,
      statements: statementsBuilder()
    )
  }

  /// Builds a `SwitchCaseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchCaseSyntax`.
  func buildSwitchCase(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchCaseSyntax {
    let result = SyntaxFactory.makeSwitchCase(
      garbageBeforeUnknownAttr?.buildGarbageNodes(format: format, leadingTrivia: nil),
      unknownAttr: unknownAttr?.buildAttribute(format: format, leadingTrivia: nil),
      garbageBetweenUnknownAttrAndLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenLabelAndStatements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchCase(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsSwitchCase`.
  public func createSwitchCase() -> SwitchCase {
    return self
  }

  /// `SwitchCase` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SwitchDefaultLabel: SyntaxBuildable, ExpressibleAsSwitchDefaultLabel {
  let garbageBeforeDefaultKeyword: GarbageNodes?
  let defaultKeyword: TokenSyntax
  let garbageBetweenDefaultKeywordAndColon: GarbageNodes?
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchDefaultLabel` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeDefaultKeyword: 
  ///   - defaultKeyword: 
  ///   - garbageBetweenDefaultKeywordAndColon: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeDefaultKeyword: ExpressibleAsGarbageNodes? = nil,
    defaultKeyword: TokenSyntax = TokenSyntax.`default`,
    garbageBetweenDefaultKeywordAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeDefaultKeyword = garbageBeforeDefaultKeyword?.createGarbageNodes()
    self.defaultKeyword = defaultKeyword
    assert(defaultKeyword.text == "default")
    self.garbageBetweenDefaultKeywordAndColon = garbageBetweenDefaultKeywordAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
  }


  /// Builds a `SwitchDefaultLabelSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchDefaultLabelSyntax`.
  func buildSwitchDefaultLabel(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchDefaultLabelSyntax {
    let result = SyntaxFactory.makeSwitchDefaultLabel(
      garbageBeforeDefaultKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      defaultKeyword: defaultKeyword,
      garbageBetweenDefaultKeywordAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchDefaultLabel(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsSwitchDefaultLabel`.
  public func createSwitchDefaultLabel() -> SwitchDefaultLabel {
    return self
  }

  /// `SwitchDefaultLabel` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CaseItem: SyntaxBuildable, ExpressibleAsCaseItem, HasTrailingComma {
  let garbageBeforePattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndWhereClause: GarbageNodes?
  let whereClause: WhereClause?
  let garbageBetweenWhereClauseAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CaseItem` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndWhereClause: 
  ///   - whereClause: 
  ///   - garbageBetweenWhereClauseAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    garbageBetweenWhereClauseAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePattern = garbageBeforePattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndWhereClause = garbageBetweenPatternAndWhereClause?.createGarbageNodes()
    self.whereClause = whereClause?.createWhereClause()
    self.garbageBetweenWhereClauseAndTrailingComma = garbageBetweenWhereClauseAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `CaseItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CaseItemSyntax`.
  func buildCaseItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CaseItemSyntax {
    let result = SyntaxFactory.makeCaseItem(
      garbageBeforePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenWhereClauseAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCaseItem(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCaseItem`.
  public func createCaseItem() -> CaseItem {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforePattern: garbageBeforePattern,
        pattern: pattern,
        garbageBetweenPatternAndWhereClause: garbageBetweenPatternAndWhereClause,
        whereClause: whereClause,
        garbageBetweenWhereClauseAndTrailingComma: garbageBetweenWhereClauseAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `CaseItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CatchItem: SyntaxBuildable, ExpressibleAsCatchItem, HasTrailingComma {
  let garbageBeforePattern: GarbageNodes?
  let pattern: PatternBuildable?
  let garbageBetweenPatternAndWhereClause: GarbageNodes?
  let whereClause: WhereClause?
  let garbageBetweenWhereClauseAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CatchItem` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndWhereClause: 
  ///   - whereClause: 
  ///   - garbageBetweenWhereClauseAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable? = nil,
    garbageBetweenPatternAndWhereClause: ExpressibleAsGarbageNodes? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    garbageBetweenWhereClauseAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePattern = garbageBeforePattern?.createGarbageNodes()
    self.pattern = pattern?.createPatternBuildable()
    self.garbageBetweenPatternAndWhereClause = garbageBetweenPatternAndWhereClause?.createGarbageNodes()
    self.whereClause = whereClause?.createWhereClause()
    self.garbageBetweenWhereClauseAndTrailingComma = garbageBetweenWhereClauseAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `CatchItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CatchItemSyntax`.
  func buildCatchItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CatchItemSyntax {
    let result = SyntaxFactory.makeCatchItem(
      garbageBeforePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern?.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndWhereClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      garbageBetweenWhereClauseAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCatchItem(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCatchItem`.
  public func createCatchItem() -> CatchItem {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforePattern: garbageBeforePattern,
        pattern: pattern,
        garbageBetweenPatternAndWhereClause: garbageBetweenPatternAndWhereClause,
        whereClause: whereClause,
        garbageBetweenWhereClauseAndTrailingComma: garbageBetweenWhereClauseAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `CatchItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SwitchCaseLabel: SyntaxBuildable, ExpressibleAsSwitchCaseLabel {
  let garbageBeforeCaseKeyword: GarbageNodes?
  let caseKeyword: TokenSyntax
  let garbageBetweenCaseKeywordAndCaseItems: GarbageNodes?
  let caseItems: CaseItemList
  let garbageBetweenCaseItemsAndColon: GarbageNodes?
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchCaseLabel` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCaseKeyword: 
  ///   - caseKeyword: 
  ///   - garbageBetweenCaseKeywordAndCaseItems: 
  ///   - caseItems: 
  ///   - garbageBetweenCaseItemsAndColon: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    garbageBetweenCaseKeywordAndCaseItems: ExpressibleAsGarbageNodes? = nil,
    caseItems: ExpressibleAsCaseItemList,
    garbageBetweenCaseItemsAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCaseKeyword = garbageBeforeCaseKeyword?.createGarbageNodes()
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.garbageBetweenCaseKeywordAndCaseItems = garbageBetweenCaseKeywordAndCaseItems?.createGarbageNodes()
    self.caseItems = caseItems.createCaseItemList()
    self.garbageBetweenCaseItemsAndColon = garbageBetweenCaseItemsAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCaseKeyword: ExpressibleAsGarbageNodes? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    garbageBetweenCaseKeywordAndCaseItems: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenCaseItemsAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @CaseItemListBuilder caseItemsBuilder: () -> ExpressibleAsCaseItemList = { CaseItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeCaseKeyword: garbageBeforeCaseKeyword,
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndCaseItems: garbageBetweenCaseKeywordAndCaseItems,
      caseItems: caseItemsBuilder(),
      garbageBetweenCaseItemsAndColon: garbageBetweenCaseItemsAndColon,
      colon: colon
    )
  }

  /// Builds a `SwitchCaseLabelSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchCaseLabelSyntax`.
  func buildSwitchCaseLabel(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchCaseLabelSyntax {
    let result = SyntaxFactory.makeSwitchCaseLabel(
      garbageBeforeCaseKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      garbageBetweenCaseKeywordAndCaseItems?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseItems: caseItems.buildCaseItemList(format: format, leadingTrivia: nil),
      garbageBetweenCaseItemsAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchCaseLabel(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsSwitchCaseLabel`.
  public func createSwitchCaseLabel() -> SwitchCaseLabel {
    return self
  }

  /// `SwitchCaseLabel` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CatchClause: SyntaxBuildable, ExpressibleAsCatchClause {
  let garbageBeforeCatchKeyword: GarbageNodes?
  let catchKeyword: TokenSyntax
  let garbageBetweenCatchKeywordAndCatchItems: GarbageNodes?
  let catchItems: CatchItemList?
  let garbageBetweenCatchItemsAndBody: GarbageNodes?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CatchClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeCatchKeyword: 
  ///   - catchKeyword: 
  ///   - garbageBetweenCatchKeywordAndCatchItems: 
  ///   - catchItems: 
  ///   - garbageBetweenCatchItemsAndBody: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCatchKeyword: ExpressibleAsGarbageNodes? = nil,
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    garbageBetweenCatchKeywordAndCatchItems: ExpressibleAsGarbageNodes? = nil,
    catchItems: ExpressibleAsCatchItemList? = nil,
    garbageBetweenCatchItemsAndBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeCatchKeyword = garbageBeforeCatchKeyword?.createGarbageNodes()
    self.catchKeyword = catchKeyword
    assert(catchKeyword.text == "catch")
    self.garbageBetweenCatchKeywordAndCatchItems = garbageBetweenCatchKeywordAndCatchItems?.createGarbageNodes()
    self.catchItems = catchItems?.createCatchItemList()
    self.garbageBetweenCatchItemsAndBody = garbageBetweenCatchItemsAndBody?.createGarbageNodes()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeCatchKeyword: ExpressibleAsGarbageNodes? = nil,
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    garbageBetweenCatchKeywordAndCatchItems: ExpressibleAsGarbageNodes? = nil,
    catchItems: ExpressibleAsCatchItemList? = nil,
    garbageBetweenCatchItemsAndBody: ExpressibleAsGarbageNodes? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeCatchKeyword: garbageBeforeCatchKeyword,
      catchKeyword: catchKeyword,
      garbageBetweenCatchKeywordAndCatchItems: garbageBetweenCatchKeywordAndCatchItems,
      catchItems: catchItems,
      garbageBetweenCatchItemsAndBody: garbageBetweenCatchItemsAndBody,
      body: bodyBuilder()
    )
  }

  /// Builds a `CatchClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CatchClauseSyntax`.
  func buildCatchClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CatchClauseSyntax {
    let result = SyntaxFactory.makeCatchClause(
      garbageBeforeCatchKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      catchKeyword: catchKeyword,
      garbageBetweenCatchKeywordAndCatchItems?.buildGarbageNodes(format: format, leadingTrivia: nil),
      catchItems: catchItems?.buildCatchItemList(format: format, leadingTrivia: nil),
      garbageBetweenCatchItemsAndBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCatchClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCatchClause`.
  public func createCatchClause() -> CatchClause {
    return self
  }

  /// `CatchClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PoundAssertStmt: StmtBuildable, ExpressibleAsPoundAssertStmt {
  let garbageBeforePoundAssert: GarbageNodes?
  let poundAssert: TokenSyntax
  let garbageBetweenPoundAssertAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndCondition: GarbageNodes?
  let condition: ExprBuildable
  let garbageBetweenConditionAndComma: GarbageNodes?
  let comma: TokenSyntax?
  let garbageBetweenCommaAndMessage: GarbageNodes?
  let message: TokenSyntax?
  let garbageBetweenMessageAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundAssertStmt` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePoundAssert: 
  ///   - poundAssert: 
  ///   - garbageBetweenPoundAssertAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndCondition: 
  ///   - condition: The assertion condition.
  ///   - garbageBetweenConditionAndComma: 
  ///   - comma: The comma after the assertion condition.
  ///   - garbageBetweenCommaAndMessage: 
  ///   - message: The assertion message.
  ///   - garbageBetweenMessageAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundAssert: ExpressibleAsGarbageNodes? = nil,
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    garbageBetweenPoundAssertAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsExprBuildable,
    garbageBetweenConditionAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndMessage: ExpressibleAsGarbageNodes? = nil,
    message: TokenSyntax? = nil,
    garbageBetweenMessageAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePoundAssert = garbageBeforePoundAssert?.createGarbageNodes()
    self.poundAssert = poundAssert
    assert(poundAssert.text == "#assert")
    self.garbageBetweenPoundAssertAndLeftParen = garbageBetweenPoundAssertAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndCondition = garbageBetweenLeftParenAndCondition?.createGarbageNodes()
    self.condition = condition.createExprBuildable()
    self.garbageBetweenConditionAndComma = garbageBetweenConditionAndComma?.createGarbageNodes()
    self.comma = comma
    assert(comma == nil || comma!.text == ",")
    self.garbageBetweenCommaAndMessage = garbageBetweenCommaAndMessage?.createGarbageNodes()
    self.message = message
    self.garbageBetweenMessageAndRightParen = garbageBetweenMessageAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePoundAssert: ExpressibleAsGarbageNodes? = nil,
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    garbageBetweenPoundAssertAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndCondition: ExpressibleAsGarbageNodes? = nil,
    condition: ExpressibleAsExprBuildable,
    garbageBetweenConditionAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndMessage: ExpressibleAsGarbageNodes? = nil,
    message: String?,
    garbageBetweenMessageAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforePoundAssert: garbageBeforePoundAssert,
      poundAssert: poundAssert,
      garbageBetweenPoundAssertAndLeftParen: garbageBetweenPoundAssertAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndCondition: garbageBetweenLeftParenAndCondition,
      condition: condition,
      garbageBetweenConditionAndComma: garbageBetweenConditionAndComma,
      comma: comma,
      garbageBetweenCommaAndMessage: garbageBetweenCommaAndMessage,
      message: message.map(TokenSyntax.stringLiteral),
      garbageBetweenMessageAndRightParen: garbageBetweenMessageAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `PoundAssertStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundAssertStmtSyntax`.
  func buildPoundAssertStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundAssertStmtSyntax {
    let result = SyntaxFactory.makePoundAssertStmt(
      garbageBeforePoundAssert?.buildGarbageNodes(format: format, leadingTrivia: nil),
      poundAssert: poundAssert,
      garbageBetweenPoundAssertAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndCondition?.buildGarbageNodes(format: format, leadingTrivia: nil),
      condition: condition.buildExpr(format: format, leadingTrivia: nil),
      garbageBetweenConditionAndComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      comma: comma,
      garbageBetweenCommaAndMessage?.buildGarbageNodes(format: format, leadingTrivia: nil),
      message: message,
      garbageBetweenMessageAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildPoundAssertStmt(format: format, leadingTrivia: additionalLeadingTrivia)
    return StmtSyntax(result)
  }

  /// Conformance to `ExpressibleAsPoundAssertStmt`.
  public func createPoundAssertStmt() -> PoundAssertStmt {
    return self
  }

  /// `PoundAssertStmt` might conform to `ExpressibleAsStmtBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createStmtBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createStmtBuildable() -> StmtBuildable {
    return self
  }

  /// `PoundAssertStmt` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct GenericWhereClause: SyntaxBuildable, ExpressibleAsGenericWhereClause {
  let garbageBeforeWhereKeyword: GarbageNodes?
  let whereKeyword: TokenSyntax
  let garbageBetweenWhereKeywordAndRequirementList: GarbageNodes?
  let requirementList: GenericRequirementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericWhereClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWhereKeyword: 
  ///   - whereKeyword: 
  ///   - garbageBetweenWhereKeywordAndRequirementList: 
  ///   - requirementList: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWhereKeyword: ExpressibleAsGarbageNodes? = nil,
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    garbageBetweenWhereKeywordAndRequirementList: ExpressibleAsGarbageNodes? = nil,
    requirementList: ExpressibleAsGenericRequirementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWhereKeyword = garbageBeforeWhereKeyword?.createGarbageNodes()
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.garbageBetweenWhereKeywordAndRequirementList = garbageBetweenWhereKeywordAndRequirementList?.createGarbageNodes()
    self.requirementList = requirementList.createGenericRequirementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWhereKeyword: ExpressibleAsGarbageNodes? = nil,
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    garbageBetweenWhereKeywordAndRequirementList: ExpressibleAsGarbageNodes? = nil,
    @GenericRequirementListBuilder requirementListBuilder: () -> ExpressibleAsGenericRequirementList = { GenericRequirementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeWhereKeyword: garbageBeforeWhereKeyword,
      whereKeyword: whereKeyword,
      garbageBetweenWhereKeywordAndRequirementList: garbageBetweenWhereKeywordAndRequirementList,
      requirementList: requirementListBuilder()
    )
  }

  /// Builds a `GenericWhereClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericWhereClauseSyntax`.
  func buildGenericWhereClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericWhereClauseSyntax {
    let result = SyntaxFactory.makeGenericWhereClause(
      garbageBeforeWhereKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      whereKeyword: whereKeyword,
      garbageBetweenWhereKeywordAndRequirementList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      requirementList: requirementList.buildGenericRequirementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericWhereClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericWhereClause`.
  public func createGenericWhereClause() -> GenericWhereClause {
    return self
  }

  /// `GenericWhereClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct GenericRequirement: SyntaxBuildable, ExpressibleAsGenericRequirement, HasTrailingComma {
  let garbageBeforeBody: GarbageNodes?
  let body: SyntaxBuildable
  let garbageBetweenBodyAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericRequirement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBody: 
  ///   - body: 
  ///   - garbageBetweenBodyAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBody: ExpressibleAsGarbageNodes? = nil,
    body: ExpressibleAsSyntaxBuildable,
    garbageBetweenBodyAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBody = garbageBeforeBody?.createGarbageNodes()
    self.body = body.createSyntaxBuildable()
    self.garbageBetweenBodyAndTrailingComma = garbageBetweenBodyAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `GenericRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericRequirementSyntax`.
  func buildGenericRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericRequirementSyntax {
    let result = SyntaxFactory.makeGenericRequirement(
      garbageBeforeBody?.buildGarbageNodes(format: format, leadingTrivia: nil),
      body: body.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenBodyAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericRequirement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericRequirement`.
  public func createGenericRequirement() -> GenericRequirement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeBody: garbageBeforeBody,
        body: body,
        garbageBetweenBodyAndTrailingComma: garbageBetweenBodyAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `GenericRequirement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SameTypeRequirement: SyntaxBuildable, ExpressibleAsSameTypeRequirement {
  let garbageBeforeLeftTypeIdentifier: GarbageNodes?
  let leftTypeIdentifier: TypeBuildable
  let garbageBetweenLeftTypeIdentifierAndEqualityToken: GarbageNodes?
  let equalityToken: TokenSyntax
  let garbageBetweenEqualityTokenAndRightTypeIdentifier: GarbageNodes?
  let rightTypeIdentifier: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SameTypeRequirement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftTypeIdentifier: 
  ///   - leftTypeIdentifier: 
  ///   - garbageBetweenLeftTypeIdentifierAndEqualityToken: 
  ///   - equalityToken: 
  ///   - garbageBetweenEqualityTokenAndRightTypeIdentifier: 
  ///   - rightTypeIdentifier: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    garbageBetweenLeftTypeIdentifierAndEqualityToken: ExpressibleAsGarbageNodes? = nil,
    equalityToken: TokenSyntax,
    garbageBetweenEqualityTokenAndRightTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftTypeIdentifier = garbageBeforeLeftTypeIdentifier?.createGarbageNodes()
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.garbageBetweenLeftTypeIdentifierAndEqualityToken = garbageBetweenLeftTypeIdentifierAndEqualityToken?.createGarbageNodes()
    self.equalityToken = equalityToken
    self.garbageBetweenEqualityTokenAndRightTypeIdentifier = garbageBetweenEqualityTokenAndRightTypeIdentifier?.createGarbageNodes()
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  /// Builds a `SameTypeRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SameTypeRequirementSyntax`.
  func buildSameTypeRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SameTypeRequirementSyntax {
    let result = SyntaxFactory.makeSameTypeRequirement(
      garbageBeforeLeftTypeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      garbageBetweenLeftTypeIdentifierAndEqualityToken?.buildGarbageNodes(format: format, leadingTrivia: nil),
      equalityToken: equalityToken,
      garbageBetweenEqualityTokenAndRightTypeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSameTypeRequirement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsSameTypeRequirement`.
  public func createSameTypeRequirement() -> SameTypeRequirement {
    return self
  }

  /// `SameTypeRequirement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct LayoutRequirement: SyntaxBuildable, ExpressibleAsLayoutRequirement {
  let garbageBeforeTypeIdentifier: GarbageNodes?
  let typeIdentifier: TypeBuildable
  let garbageBetweenTypeIdentifierAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndLayoutConstraint: GarbageNodes?
  let layoutConstraint: TokenSyntax
  let garbageBetweenLayoutConstraintAndLeftParen: GarbageNodes?
  let leftParen: TokenSyntax?
  let garbageBetweenLeftParenAndSize: GarbageNodes?
  let size: TokenSyntax?
  let garbageBetweenSizeAndComma: GarbageNodes?
  let comma: TokenSyntax?
  let garbageBetweenCommaAndAlignment: GarbageNodes?
  let alignment: TokenSyntax?
  let garbageBetweenAlignmentAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `LayoutRequirement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeTypeIdentifier: 
  ///   - typeIdentifier: 
  ///   - garbageBetweenTypeIdentifierAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndLayoutConstraint: 
  ///   - layoutConstraint: 
  ///   - garbageBetweenLayoutConstraintAndLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndSize: 
  ///   - size: 
  ///   - garbageBetweenSizeAndComma: 
  ///   - comma: 
  ///   - garbageBetweenCommaAndAlignment: 
  ///   - alignment: 
  ///   - garbageBetweenAlignmentAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    typeIdentifier: ExpressibleAsTypeBuildable,
    garbageBetweenTypeIdentifierAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndLayoutConstraint: ExpressibleAsGarbageNodes? = nil,
    layoutConstraint: TokenSyntax,
    garbageBetweenLayoutConstraintAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndSize: ExpressibleAsGarbageNodes? = nil,
    size: TokenSyntax? = nil,
    garbageBetweenSizeAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndAlignment: ExpressibleAsGarbageNodes? = nil,
    alignment: TokenSyntax? = nil,
    garbageBetweenAlignmentAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeTypeIdentifier = garbageBeforeTypeIdentifier?.createGarbageNodes()
    self.typeIdentifier = typeIdentifier.createTypeBuildable()
    self.garbageBetweenTypeIdentifierAndColon = garbageBetweenTypeIdentifierAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndLayoutConstraint = garbageBetweenColonAndLayoutConstraint?.createGarbageNodes()
    self.layoutConstraint = layoutConstraint
    self.garbageBetweenLayoutConstraintAndLeftParen = garbageBetweenLayoutConstraintAndLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.garbageBetweenLeftParenAndSize = garbageBetweenLeftParenAndSize?.createGarbageNodes()
    self.size = size
    self.garbageBetweenSizeAndComma = garbageBetweenSizeAndComma?.createGarbageNodes()
    self.comma = comma
    assert(comma == nil || comma!.text == ",")
    self.garbageBetweenCommaAndAlignment = garbageBetweenCommaAndAlignment?.createGarbageNodes()
    self.alignment = alignment
    self.garbageBetweenAlignmentAndRightParen = garbageBetweenAlignmentAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    typeIdentifier: ExpressibleAsTypeBuildable,
    garbageBetweenTypeIdentifierAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndLayoutConstraint: ExpressibleAsGarbageNodes? = nil,
    layoutConstraint: String,
    garbageBetweenLayoutConstraintAndLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax? = nil,
    garbageBetweenLeftParenAndSize: ExpressibleAsGarbageNodes? = nil,
    size: String?,
    garbageBetweenSizeAndComma: ExpressibleAsGarbageNodes? = nil,
    comma: TokenSyntax? = nil,
    garbageBetweenCommaAndAlignment: ExpressibleAsGarbageNodes? = nil,
    alignment: String?,
    garbageBetweenAlignmentAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeTypeIdentifier: garbageBeforeTypeIdentifier,
      typeIdentifier: typeIdentifier,
      garbageBetweenTypeIdentifierAndColon: garbageBetweenTypeIdentifierAndColon,
      colon: colon,
      garbageBetweenColonAndLayoutConstraint: garbageBetweenColonAndLayoutConstraint,
      layoutConstraint: TokenSyntax.identifier(layoutConstraint),
      garbageBetweenLayoutConstraintAndLeftParen: garbageBetweenLayoutConstraintAndLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndSize: garbageBetweenLeftParenAndSize,
      size: size.map(TokenSyntax.integerLiteral),
      garbageBetweenSizeAndComma: garbageBetweenSizeAndComma,
      comma: comma,
      garbageBetweenCommaAndAlignment: garbageBetweenCommaAndAlignment,
      alignment: alignment.map(TokenSyntax.integerLiteral),
      garbageBetweenAlignmentAndRightParen: garbageBetweenAlignmentAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `LayoutRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `LayoutRequirementSyntax`.
  func buildLayoutRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> LayoutRequirementSyntax {
    let result = SyntaxFactory.makeLayoutRequirement(
      garbageBeforeTypeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeIdentifier: typeIdentifier.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeIdentifierAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndLayoutConstraint?.buildGarbageNodes(format: format, leadingTrivia: nil),
      layoutConstraint: layoutConstraint,
      garbageBetweenLayoutConstraintAndLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndSize?.buildGarbageNodes(format: format, leadingTrivia: nil),
      size: size,
      garbageBetweenSizeAndComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      comma: comma,
      garbageBetweenCommaAndAlignment?.buildGarbageNodes(format: format, leadingTrivia: nil),
      alignment: alignment,
      garbageBetweenAlignmentAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildLayoutRequirement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsLayoutRequirement`.
  public func createLayoutRequirement() -> LayoutRequirement {
    return self
  }

  /// `LayoutRequirement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct GenericParameter: SyntaxBuildable, ExpressibleAsGenericParameter, HasTrailingComma {
  let garbageBeforeAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndColon: GarbageNodes?
  let colon: TokenSyntax?
  let garbageBetweenColonAndInheritedType: GarbageNodes?
  let inheritedType: TypeBuildable?
  let garbageBetweenInheritedTypeAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericParameter` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndInheritedType: 
  ///   - inheritedType: 
  ///   - garbageBetweenInheritedTypeAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndInheritedType: ExpressibleAsGarbageNodes? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenInheritedTypeAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeAttributes = garbageBeforeAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndName = garbageBetweenAttributesAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndColon = garbageBetweenNameAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.garbageBetweenColonAndInheritedType = garbageBetweenColonAndInheritedType?.createGarbageNodes()
    self.inheritedType = inheritedType?.createTypeBuildable()
    self.garbageBetweenInheritedTypeAndTrailingComma = garbageBetweenInheritedTypeAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndInheritedType: ExpressibleAsGarbageNodes? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenInheritedTypeAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeAttributes: garbageBeforeAttributes,
      attributes: attributes,
      garbageBetweenAttributesAndName: garbageBetweenAttributesAndName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndColon: garbageBetweenNameAndColon,
      colon: colon,
      garbageBetweenColonAndInheritedType: garbageBetweenColonAndInheritedType,
      inheritedType: inheritedType,
      garbageBetweenInheritedTypeAndTrailingComma: garbageBetweenInheritedTypeAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `GenericParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericParameterSyntax`.
  func buildGenericParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericParameterSyntax {
    let result = SyntaxFactory.makeGenericParameter(
      garbageBeforeAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndInheritedType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inheritedType: inheritedType?.buildType(format: format, leadingTrivia: nil),
      garbageBetweenInheritedTypeAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericParameter(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericParameter`.
  public func createGenericParameter() -> GenericParameter {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeAttributes: garbageBeforeAttributes,
        attributes: attributes,
        garbageBetweenAttributesAndName: garbageBetweenAttributesAndName,
        name: name,
        garbageBetweenNameAndColon: garbageBetweenNameAndColon,
        colon: colon,
        garbageBetweenColonAndInheritedType: garbageBetweenColonAndInheritedType,
        inheritedType: inheritedType,
        garbageBetweenInheritedTypeAndTrailingComma: garbageBetweenInheritedTypeAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `GenericParameter` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PrimaryAssociatedType: SyntaxBuildable, ExpressibleAsPrimaryAssociatedType, HasTrailingComma {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrimaryAssociatedType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndTrailingComma = garbageBetweenNameAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: String,
    garbageBetweenNameAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeName: garbageBeforeName,
      name: TokenSyntax.identifier(name),
      garbageBetweenNameAndTrailingComma: garbageBetweenNameAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `PrimaryAssociatedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrimaryAssociatedTypeSyntax`.
  func buildPrimaryAssociatedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedType(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrimaryAssociatedType(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrimaryAssociatedType`.
  public func createPrimaryAssociatedType() -> PrimaryAssociatedType {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeName: garbageBeforeName,
        name: name,
        garbageBetweenNameAndTrailingComma: garbageBetweenNameAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `PrimaryAssociatedType` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct GenericParameterClause: SyntaxBuildable, ExpressibleAsGenericParameterClause {
  let garbageBeforeLeftAngleBracket: GarbageNodes?
  let leftAngleBracket: TokenSyntax
  let garbageBetweenLeftAngleBracketAndGenericParameterList: GarbageNodes?
  let genericParameterList: GenericParameterList
  let garbageBetweenGenericParameterListAndRightAngleBracket: GarbageNodes?
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftAngleBracket: 
  ///   - leftAngleBracket: 
  ///   - garbageBetweenLeftAngleBracketAndGenericParameterList: 
  ///   - genericParameterList: 
  ///   - garbageBetweenGenericParameterListAndRightAngleBracket: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftAngleBracket: ExpressibleAsGarbageNodes? = nil,
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    garbageBetweenLeftAngleBracketAndGenericParameterList: ExpressibleAsGarbageNodes? = nil,
    genericParameterList: ExpressibleAsGenericParameterList,
    garbageBetweenGenericParameterListAndRightAngleBracket: ExpressibleAsGarbageNodes? = nil,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftAngleBracket = garbageBeforeLeftAngleBracket?.createGarbageNodes()
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.garbageBetweenLeftAngleBracketAndGenericParameterList = garbageBetweenLeftAngleBracketAndGenericParameterList?.createGarbageNodes()
    self.genericParameterList = genericParameterList.createGenericParameterList()
    self.garbageBetweenGenericParameterListAndRightAngleBracket = garbageBetweenGenericParameterListAndRightAngleBracket?.createGarbageNodes()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftAngleBracket: ExpressibleAsGarbageNodes? = nil,
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    garbageBetweenLeftAngleBracketAndGenericParameterList: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenGenericParameterListAndRightAngleBracket: ExpressibleAsGarbageNodes? = nil,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> ExpressibleAsGenericParameterList = { GenericParameterList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftAngleBracket: garbageBeforeLeftAngleBracket,
      leftAngleBracket: leftAngleBracket,
      garbageBetweenLeftAngleBracketAndGenericParameterList: garbageBetweenLeftAngleBracketAndGenericParameterList,
      genericParameterList: genericParameterListBuilder(),
      garbageBetweenGenericParameterListAndRightAngleBracket: garbageBetweenGenericParameterListAndRightAngleBracket,
      rightAngleBracket: rightAngleBracket
    )
  }

  /// Builds a `GenericParameterClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericParameterClauseSyntax`.
  func buildGenericParameterClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericParameterClauseSyntax {
    let result = SyntaxFactory.makeGenericParameterClause(
      garbageBeforeLeftAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftAngleBracket: leftAngleBracket,
      garbageBetweenLeftAngleBracketAndGenericParameterList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericParameterList: genericParameterList.buildGenericParameterList(format: format, leadingTrivia: nil),
      garbageBetweenGenericParameterListAndRightAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericParameterClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericParameterClause`.
  public func createGenericParameterClause() -> GenericParameterClause {
    return self
  }

  /// `GenericParameterClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ConformanceRequirement: SyntaxBuildable, ExpressibleAsConformanceRequirement {
  let garbageBeforeLeftTypeIdentifier: GarbageNodes?
  let leftTypeIdentifier: TypeBuildable
  let garbageBetweenLeftTypeIdentifierAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndRightTypeIdentifier: GarbageNodes?
  let rightTypeIdentifier: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConformanceRequirement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftTypeIdentifier: 
  ///   - leftTypeIdentifier: 
  ///   - garbageBetweenLeftTypeIdentifierAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndRightTypeIdentifier: 
  ///   - rightTypeIdentifier: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    garbageBetweenLeftTypeIdentifierAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndRightTypeIdentifier: ExpressibleAsGarbageNodes? = nil,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftTypeIdentifier = garbageBeforeLeftTypeIdentifier?.createGarbageNodes()
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.garbageBetweenLeftTypeIdentifierAndColon = garbageBetweenLeftTypeIdentifierAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndRightTypeIdentifier = garbageBetweenColonAndRightTypeIdentifier?.createGarbageNodes()
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  /// Builds a `ConformanceRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConformanceRequirementSyntax`.
  func buildConformanceRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConformanceRequirementSyntax {
    let result = SyntaxFactory.makeConformanceRequirement(
      garbageBeforeLeftTypeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      garbageBetweenLeftTypeIdentifierAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndRightTypeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildConformanceRequirement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsConformanceRequirement`.
  public func createConformanceRequirement() -> ConformanceRequirement {
    return self
  }

  /// `ConformanceRequirement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PrimaryAssociatedTypeClause: SyntaxBuildable, ExpressibleAsPrimaryAssociatedTypeClause {
  let garbageBeforeLeftAngleBracket: GarbageNodes?
  let leftAngleBracket: TokenSyntax
  let garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: GarbageNodes?
  let primaryAssociatedTypeList: PrimaryAssociatedTypeList
  let garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: GarbageNodes?
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrimaryAssociatedTypeClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftAngleBracket: 
  ///   - leftAngleBracket: 
  ///   - garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: 
  ///   - primaryAssociatedTypeList: 
  ///   - garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftAngleBracket: ExpressibleAsGarbageNodes? = nil,
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: ExpressibleAsGarbageNodes? = nil,
    primaryAssociatedTypeList: ExpressibleAsPrimaryAssociatedTypeList,
    garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: ExpressibleAsGarbageNodes? = nil,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftAngleBracket = garbageBeforeLeftAngleBracket?.createGarbageNodes()
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList = garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.createGarbageNodes()
    self.primaryAssociatedTypeList = primaryAssociatedTypeList.createPrimaryAssociatedTypeList()
    self.garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket = garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.createGarbageNodes()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }


  /// Builds a `PrimaryAssociatedTypeClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrimaryAssociatedTypeClauseSyntax`.
  func buildPrimaryAssociatedTypeClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeClauseSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedTypeClause(
      garbageBeforeLeftAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftAngleBracket: leftAngleBracket,
      garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.buildGarbageNodes(format: format, leadingTrivia: nil),
      primaryAssociatedTypeList: primaryAssociatedTypeList.buildPrimaryAssociatedTypeList(format: format, leadingTrivia: nil),
      garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrimaryAssociatedTypeClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrimaryAssociatedTypeClause`.
  public func createPrimaryAssociatedTypeClause() -> PrimaryAssociatedTypeClause {
    return self
  }

  /// `PrimaryAssociatedTypeClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct SimpleTypeIdentifier: TypeBuildable, ExpressibleAsSimpleTypeIdentifier {
  let garbageBeforeName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndGenericArgumentClause: GarbageNodes?
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SimpleTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeName: 
  ///   - name: 
  ///   - garbageBetweenNameAndGenericArgumentClause: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndGenericArgumentClause: ExpressibleAsGarbageNodes? = nil,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeName = garbageBeforeName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndGenericArgumentClause = garbageBetweenNameAndGenericArgumentClause?.createGarbageNodes()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  /// Builds a `SimpleTypeIdentifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SimpleTypeIdentifierSyntax`.
  func buildSimpleTypeIdentifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SimpleTypeIdentifierSyntax {
    let result = SyntaxFactory.makeSimpleTypeIdentifier(
      garbageBeforeName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndGenericArgumentClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildSimpleTypeIdentifier(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsSimpleTypeIdentifier`.
  public func createSimpleTypeIdentifier() -> SimpleTypeIdentifier {
    return self
  }

  /// `SimpleTypeIdentifier` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `SimpleTypeIdentifier` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MemberTypeIdentifier: TypeBuildable, ExpressibleAsMemberTypeIdentifier {
  let garbageBeforeBaseType: GarbageNodes?
  let baseType: TypeBuildable
  let garbageBetweenBaseTypeAndPeriod: GarbageNodes?
  let period: TokenSyntax
  let garbageBetweenPeriodAndName: GarbageNodes?
  let name: TokenSyntax
  let garbageBetweenNameAndGenericArgumentClause: GarbageNodes?
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBaseType: 
  ///   - baseType: 
  ///   - garbageBetweenBaseTypeAndPeriod: 
  ///   - period: 
  ///   - garbageBetweenPeriodAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndGenericArgumentClause: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable,
    garbageBetweenBaseTypeAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax,
    garbageBetweenPeriodAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax,
    garbageBetweenNameAndGenericArgumentClause: ExpressibleAsGarbageNodes? = nil,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBaseType = garbageBeforeBaseType?.createGarbageNodes()
    self.baseType = baseType.createTypeBuildable()
    self.garbageBetweenBaseTypeAndPeriod = garbageBetweenBaseTypeAndPeriod?.createGarbageNodes()
    self.period = period
    assert(period.text == "." || period.text == ".")
    self.garbageBetweenPeriodAndName = garbageBetweenPeriodAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndGenericArgumentClause = garbageBetweenNameAndGenericArgumentClause?.createGarbageNodes()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  /// Builds a `MemberTypeIdentifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberTypeIdentifierSyntax`.
  func buildMemberTypeIdentifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberTypeIdentifierSyntax {
    let result = SyntaxFactory.makeMemberTypeIdentifier(
      garbageBeforeBaseType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenBaseTypeAndPeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      period: period,
      garbageBetweenPeriodAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndGenericArgumentClause?.buildGarbageNodes(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildMemberTypeIdentifier(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsMemberTypeIdentifier`.
  public func createMemberTypeIdentifier() -> MemberTypeIdentifier {
    return self
  }

  /// `MemberTypeIdentifier` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `MemberTypeIdentifier` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ClassRestrictionType: TypeBuildable, ExpressibleAsClassRestrictionType {
  let garbageBeforeClassKeyword: GarbageNodes?
  let classKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClassRestrictionType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeClassKeyword: 
  ///   - classKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeClassKeyword: ExpressibleAsGarbageNodes? = nil,
    classKeyword: TokenSyntax = TokenSyntax.`class`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeClassKeyword = garbageBeforeClassKeyword?.createGarbageNodes()
    self.classKeyword = classKeyword
    assert(classKeyword.text == "class")
  }


  /// Builds a `ClassRestrictionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClassRestrictionTypeSyntax`.
  func buildClassRestrictionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClassRestrictionTypeSyntax {
    let result = SyntaxFactory.makeClassRestrictionType(
      garbageBeforeClassKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      classKeyword: classKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildClassRestrictionType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsClassRestrictionType`.
  public func createClassRestrictionType() -> ClassRestrictionType {
    return self
  }

  /// `ClassRestrictionType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `ClassRestrictionType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ArrayType: TypeBuildable, ExpressibleAsArrayType {
  let garbageBeforeLeftSquareBracket: GarbageNodes?
  let leftSquareBracket: TokenSyntax
  let garbageBetweenLeftSquareBracketAndElementType: GarbageNodes?
  let elementType: TypeBuildable
  let garbageBetweenElementTypeAndRightSquareBracket: GarbageNodes?
  let rightSquareBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftSquareBracket: 
  ///   - leftSquareBracket: 
  ///   - garbageBetweenLeftSquareBracketAndElementType: 
  ///   - elementType: 
  ///   - garbageBetweenElementTypeAndRightSquareBracket: 
  ///   - rightSquareBracket: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquareBracket: ExpressibleAsGarbageNodes? = nil,
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareBracketAndElementType: ExpressibleAsGarbageNodes? = nil,
    elementType: ExpressibleAsTypeBuildable,
    garbageBetweenElementTypeAndRightSquareBracket: ExpressibleAsGarbageNodes? = nil,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftSquareBracket = garbageBeforeLeftSquareBracket?.createGarbageNodes()
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.garbageBetweenLeftSquareBracketAndElementType = garbageBetweenLeftSquareBracketAndElementType?.createGarbageNodes()
    self.elementType = elementType.createTypeBuildable()
    self.garbageBetweenElementTypeAndRightSquareBracket = garbageBetweenElementTypeAndRightSquareBracket?.createGarbageNodes()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  /// Builds a `ArrayTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayTypeSyntax`.
  func buildArrayType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayTypeSyntax {
    let result = SyntaxFactory.makeArrayType(
      garbageBeforeLeftSquareBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftSquareBracket: leftSquareBracket,
      garbageBetweenLeftSquareBracketAndElementType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elementType: elementType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenElementTypeAndRightSquareBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildArrayType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsArrayType`.
  public func createArrayType() -> ArrayType {
    return self
  }

  /// `ArrayType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `ArrayType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct DictionaryType: TypeBuildable, ExpressibleAsDictionaryType {
  let garbageBeforeLeftSquareBracket: GarbageNodes?
  let leftSquareBracket: TokenSyntax
  let garbageBetweenLeftSquareBracketAndKeyType: GarbageNodes?
  let keyType: TypeBuildable
  let garbageBetweenKeyTypeAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndValueType: GarbageNodes?
  let valueType: TypeBuildable
  let garbageBetweenValueTypeAndRightSquareBracket: GarbageNodes?
  let rightSquareBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftSquareBracket: 
  ///   - leftSquareBracket: 
  ///   - garbageBetweenLeftSquareBracketAndKeyType: 
  ///   - keyType: 
  ///   - garbageBetweenKeyTypeAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndValueType: 
  ///   - valueType: 
  ///   - garbageBetweenValueTypeAndRightSquareBracket: 
  ///   - rightSquareBracket: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftSquareBracket: ExpressibleAsGarbageNodes? = nil,
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    garbageBetweenLeftSquareBracketAndKeyType: ExpressibleAsGarbageNodes? = nil,
    keyType: ExpressibleAsTypeBuildable,
    garbageBetweenKeyTypeAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValueType: ExpressibleAsGarbageNodes? = nil,
    valueType: ExpressibleAsTypeBuildable,
    garbageBetweenValueTypeAndRightSquareBracket: ExpressibleAsGarbageNodes? = nil,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftSquareBracket = garbageBeforeLeftSquareBracket?.createGarbageNodes()
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.garbageBetweenLeftSquareBracketAndKeyType = garbageBetweenLeftSquareBracketAndKeyType?.createGarbageNodes()
    self.keyType = keyType.createTypeBuildable()
    self.garbageBetweenKeyTypeAndColon = garbageBetweenKeyTypeAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndValueType = garbageBetweenColonAndValueType?.createGarbageNodes()
    self.valueType = valueType.createTypeBuildable()
    self.garbageBetweenValueTypeAndRightSquareBracket = garbageBetweenValueTypeAndRightSquareBracket?.createGarbageNodes()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  /// Builds a `DictionaryTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryTypeSyntax`.
  func buildDictionaryType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryTypeSyntax {
    let result = SyntaxFactory.makeDictionaryType(
      garbageBeforeLeftSquareBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftSquareBracket: leftSquareBracket,
      garbageBetweenLeftSquareBracketAndKeyType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      keyType: keyType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenKeyTypeAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndValueType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      valueType: valueType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenValueTypeAndRightSquareBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildDictionaryType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsDictionaryType`.
  public func createDictionaryType() -> DictionaryType {
    return self
  }

  /// `DictionaryType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `DictionaryType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct MetatypeType: TypeBuildable, ExpressibleAsMetatypeType {
  let garbageBeforeBaseType: GarbageNodes?
  let baseType: TypeBuildable
  let garbageBetweenBaseTypeAndPeriod: GarbageNodes?
  let period: TokenSyntax
  let garbageBetweenPeriodAndTypeOrProtocol: GarbageNodes?
  let typeOrProtocol: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MetatypeType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeBaseType: 
  ///   - baseType: 
  ///   - garbageBetweenBaseTypeAndPeriod: 
  ///   - period: 
  ///   - garbageBetweenPeriodAndTypeOrProtocol: 
  ///   - typeOrProtocol: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable,
    garbageBetweenBaseTypeAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    garbageBetweenPeriodAndTypeOrProtocol: ExpressibleAsGarbageNodes? = nil,
    typeOrProtocol: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeBaseType = garbageBeforeBaseType?.createGarbageNodes()
    self.baseType = baseType.createTypeBuildable()
    self.garbageBetweenBaseTypeAndPeriod = garbageBetweenBaseTypeAndPeriod?.createGarbageNodes()
    self.period = period
    assert(period.text == ".")
    self.garbageBetweenPeriodAndTypeOrProtocol = garbageBetweenPeriodAndTypeOrProtocol?.createGarbageNodes()
    self.typeOrProtocol = typeOrProtocol
    assert(typeOrProtocol.text == "Type" || typeOrProtocol.text == "Protocol")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable,
    garbageBetweenBaseTypeAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    garbageBetweenPeriodAndTypeOrProtocol: ExpressibleAsGarbageNodes? = nil,
    typeOrProtocol: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeBaseType: garbageBeforeBaseType,
      baseType: baseType,
      garbageBetweenBaseTypeAndPeriod: garbageBetweenBaseTypeAndPeriod,
      period: period,
      garbageBetweenPeriodAndTypeOrProtocol: garbageBetweenPeriodAndTypeOrProtocol,
      typeOrProtocol: TokenSyntax.identifier(typeOrProtocol)
    )
  }

  /// Builds a `MetatypeTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MetatypeTypeSyntax`.
  func buildMetatypeType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MetatypeTypeSyntax {
    let result = SyntaxFactory.makeMetatypeType(
      garbageBeforeBaseType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenBaseTypeAndPeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      period: period,
      garbageBetweenPeriodAndTypeOrProtocol?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeOrProtocol: typeOrProtocol
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildMetatypeType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsMetatypeType`.
  public func createMetatypeType() -> MetatypeType {
    return self
  }

  /// `MetatypeType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `MetatypeType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct OptionalType: TypeBuildable, ExpressibleAsOptionalType {
  let garbageBeforeWrappedType: GarbageNodes?
  let wrappedType: TypeBuildable
  let garbageBetweenWrappedTypeAndQuestionMark: GarbageNodes?
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWrappedType: 
  ///   - wrappedType: 
  ///   - garbageBetweenWrappedTypeAndQuestionMark: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWrappedType: ExpressibleAsGarbageNodes? = nil,
    wrappedType: ExpressibleAsTypeBuildable,
    garbageBetweenWrappedTypeAndQuestionMark: ExpressibleAsGarbageNodes? = nil,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWrappedType = garbageBeforeWrappedType?.createGarbageNodes()
    self.wrappedType = wrappedType.createTypeBuildable()
    self.garbageBetweenWrappedTypeAndQuestionMark = garbageBetweenWrappedTypeAndQuestionMark?.createGarbageNodes()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalTypeSyntax`.
  func buildOptionalType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalTypeSyntax {
    let result = SyntaxFactory.makeOptionalType(
      garbageBeforeWrappedType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenWrappedTypeAndQuestionMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildOptionalType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsOptionalType`.
  public func createOptionalType() -> OptionalType {
    return self
  }

  /// `OptionalType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `OptionalType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ConstrainedSugarType: TypeBuildable, ExpressibleAsConstrainedSugarType {
  let garbageBeforeSomeOrAnySpecifier: GarbageNodes?
  let someOrAnySpecifier: TokenSyntax
  let garbageBetweenSomeOrAnySpecifierAndBaseType: GarbageNodes?
  let baseType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConstrainedSugarType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSomeOrAnySpecifier: 
  ///   - someOrAnySpecifier: 
  ///   - garbageBetweenSomeOrAnySpecifierAndBaseType: 
  ///   - baseType: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSomeOrAnySpecifier: ExpressibleAsGarbageNodes? = nil,
    someOrAnySpecifier: TokenSyntax,
    garbageBetweenSomeOrAnySpecifierAndBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSomeOrAnySpecifier = garbageBeforeSomeOrAnySpecifier?.createGarbageNodes()
    self.someOrAnySpecifier = someOrAnySpecifier
    assert(someOrAnySpecifier.text == "some" || someOrAnySpecifier.text == "any")
    self.garbageBetweenSomeOrAnySpecifierAndBaseType = garbageBetweenSomeOrAnySpecifierAndBaseType?.createGarbageNodes()
    self.baseType = baseType.createTypeBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSomeOrAnySpecifier: ExpressibleAsGarbageNodes? = nil,
    someOrAnySpecifier: String,
    garbageBetweenSomeOrAnySpecifierAndBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeSomeOrAnySpecifier: garbageBeforeSomeOrAnySpecifier,
      someOrAnySpecifier: TokenSyntax.identifier(someOrAnySpecifier),
      garbageBetweenSomeOrAnySpecifierAndBaseType: garbageBetweenSomeOrAnySpecifierAndBaseType,
      baseType: baseType
    )
  }

  /// Builds a `ConstrainedSugarTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConstrainedSugarTypeSyntax`.
  func buildConstrainedSugarType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConstrainedSugarTypeSyntax {
    let result = SyntaxFactory.makeConstrainedSugarType(
      garbageBeforeSomeOrAnySpecifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      someOrAnySpecifier: someOrAnySpecifier,
      garbageBetweenSomeOrAnySpecifierAndBaseType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildConstrainedSugarType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsConstrainedSugarType`.
  public func createConstrainedSugarType() -> ConstrainedSugarType {
    return self
  }

  /// `ConstrainedSugarType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `ConstrainedSugarType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ImplicitlyUnwrappedOptionalType: TypeBuildable, ExpressibleAsImplicitlyUnwrappedOptionalType {
  let garbageBeforeWrappedType: GarbageNodes?
  let wrappedType: TypeBuildable
  let garbageBetweenWrappedTypeAndExclamationMark: GarbageNodes?
  let exclamationMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImplicitlyUnwrappedOptionalType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWrappedType: 
  ///   - wrappedType: 
  ///   - garbageBetweenWrappedTypeAndExclamationMark: 
  ///   - exclamationMark: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWrappedType: ExpressibleAsGarbageNodes? = nil,
    wrappedType: ExpressibleAsTypeBuildable,
    garbageBetweenWrappedTypeAndExclamationMark: ExpressibleAsGarbageNodes? = nil,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWrappedType = garbageBeforeWrappedType?.createGarbageNodes()
    self.wrappedType = wrappedType.createTypeBuildable()
    self.garbageBetweenWrappedTypeAndExclamationMark = garbageBetweenWrappedTypeAndExclamationMark?.createGarbageNodes()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  /// Builds a `ImplicitlyUnwrappedOptionalTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImplicitlyUnwrappedOptionalTypeSyntax`.
  func buildImplicitlyUnwrappedOptionalType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let result = SyntaxFactory.makeImplicitlyUnwrappedOptionalType(
      garbageBeforeWrappedType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenWrappedTypeAndExclamationMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildImplicitlyUnwrappedOptionalType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsImplicitlyUnwrappedOptionalType`.
  public func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType {
    return self
  }

  /// `ImplicitlyUnwrappedOptionalType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `ImplicitlyUnwrappedOptionalType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct CompositionTypeElement: SyntaxBuildable, ExpressibleAsCompositionTypeElement {
  let garbageBeforeType: GarbageNodes?
  let type: TypeBuildable
  let garbageBetweenTypeAndAmpersand: GarbageNodes?
  let ampersand: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CompositionTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeType: 
  ///   - type: 
  ///   - garbageBetweenTypeAndAmpersand: 
  ///   - ampersand: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable,
    garbageBetweenTypeAndAmpersand: ExpressibleAsGarbageNodes? = nil,
    ampersand: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeType = garbageBeforeType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
    self.garbageBetweenTypeAndAmpersand = garbageBetweenTypeAndAmpersand?.createGarbageNodes()
    self.ampersand = ampersand
    assert(ampersand == nil || ampersand!.text == "&")
  }


  /// Builds a `CompositionTypeElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CompositionTypeElementSyntax`.
  func buildCompositionTypeElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CompositionTypeElementSyntax {
    let result = SyntaxFactory.makeCompositionTypeElement(
      garbageBeforeType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeAndAmpersand?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ampersand: ampersand
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCompositionTypeElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCompositionTypeElement`.
  public func createCompositionTypeElement() -> CompositionTypeElement {
    return self
  }

  /// `CompositionTypeElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CompositionType: TypeBuildable, ExpressibleAsCompositionType {
  let garbageBeforeElements: GarbageNodes?
  let elements: CompositionTypeElementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CompositionType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeElements: 
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsCompositionTypeElementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeElements = garbageBeforeElements?.createGarbageNodes()
    self.elements = elements.createCompositionTypeElementList()
  }


  /// Builds a `CompositionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CompositionTypeSyntax`.
  func buildCompositionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CompositionTypeSyntax {
    let result = SyntaxFactory.makeCompositionType(
      garbageBeforeElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildCompositionTypeElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildCompositionType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsCompositionType`.
  public func createCompositionType() -> CompositionType {
    return self
  }

  /// `CompositionType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `CompositionType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TupleTypeElement: SyntaxBuildable, ExpressibleAsTupleTypeElement, HasTrailingComma {
  let garbageBeforeInOut: GarbageNodes?
  let inOut: TokenSyntax?
  let garbageBetweenInOutAndName: GarbageNodes?
  let name: TokenSyntax?
  let garbageBetweenNameAndSecondName: GarbageNodes?
  let secondName: TokenSyntax?
  let garbageBetweenSecondNameAndColon: GarbageNodes?
  let colon: TokenSyntax?
  let garbageBetweenColonAndType: GarbageNodes?
  let type: TypeBuildable
  let garbageBetweenTypeAndEllipsis: GarbageNodes?
  let ellipsis: TokenSyntax?
  let garbageBetweenEllipsisAndInitializer: GarbageNodes?
  let initializer: InitializerClause?
  let garbageBetweenInitializerAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeInOut: 
  ///   - inOut: 
  ///   - garbageBetweenInOutAndName: 
  ///   - name: 
  ///   - garbageBetweenNameAndSecondName: 
  ///   - secondName: 
  ///   - garbageBetweenSecondNameAndColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndType: 
  ///   - type: 
  ///   - garbageBetweenTypeAndEllipsis: 
  ///   - ellipsis: 
  ///   - garbageBetweenEllipsisAndInitializer: 
  ///   - initializer: 
  ///   - garbageBetweenInitializerAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeInOut: ExpressibleAsGarbageNodes? = nil,
    inOut: TokenSyntax? = nil,
    garbageBetweenInOutAndName: ExpressibleAsGarbageNodes? = nil,
    name: TokenSyntax? = nil,
    garbageBetweenNameAndSecondName: ExpressibleAsGarbageNodes? = nil,
    secondName: TokenSyntax? = nil,
    garbageBetweenSecondNameAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax? = nil,
    garbageBetweenColonAndType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable,
    garbageBetweenTypeAndEllipsis: ExpressibleAsGarbageNodes? = nil,
    ellipsis: TokenSyntax? = nil,
    garbageBetweenEllipsisAndInitializer: ExpressibleAsGarbageNodes? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    garbageBetweenInitializerAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeInOut = garbageBeforeInOut?.createGarbageNodes()
    self.inOut = inOut
    assert(inOut == nil || inOut!.text == "inout")
    self.garbageBetweenInOutAndName = garbageBetweenInOutAndName?.createGarbageNodes()
    self.name = name
    self.garbageBetweenNameAndSecondName = garbageBetweenNameAndSecondName?.createGarbageNodes()
    self.secondName = secondName
    self.garbageBetweenSecondNameAndColon = garbageBetweenSecondNameAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.garbageBetweenColonAndType = garbageBetweenColonAndType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
    self.garbageBetweenTypeAndEllipsis = garbageBetweenTypeAndEllipsis?.createGarbageNodes()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ellipsis!.text == "...")
    self.garbageBetweenEllipsisAndInitializer = garbageBetweenEllipsisAndInitializer?.createGarbageNodes()
    self.initializer = initializer?.createInitializerClause()
    self.garbageBetweenInitializerAndTrailingComma = garbageBetweenInitializerAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `TupleTypeElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleTypeElementSyntax`.
  func buildTupleTypeElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleTypeElementSyntax {
    let result = SyntaxFactory.makeTupleTypeElement(
      garbageBeforeInOut?.buildGarbageNodes(format: format, leadingTrivia: nil),
      inOut: inOut,
      garbageBetweenInOutAndName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      name: name,
      garbageBetweenNameAndSecondName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      secondName: secondName,
      garbageBetweenSecondNameAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeAndEllipsis?.buildGarbageNodes(format: format, leadingTrivia: nil),
      ellipsis: ellipsis,
      garbageBetweenEllipsisAndInitializer?.buildGarbageNodes(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil),
      garbageBetweenInitializerAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTupleTypeElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTupleTypeElement`.
  public func createTupleTypeElement() -> TupleTypeElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeInOut: garbageBeforeInOut,
        inOut: inOut,
        garbageBetweenInOutAndName: garbageBetweenInOutAndName,
        name: name,
        garbageBetweenNameAndSecondName: garbageBetweenNameAndSecondName,
        secondName: secondName,
        garbageBetweenSecondNameAndColon: garbageBetweenSecondNameAndColon,
        colon: colon,
        garbageBetweenColonAndType: garbageBetweenColonAndType,
        type: type,
        garbageBetweenTypeAndEllipsis: garbageBetweenTypeAndEllipsis,
        ellipsis: ellipsis,
        garbageBetweenEllipsisAndInitializer: garbageBetweenEllipsisAndInitializer,
        initializer: initializer,
        garbageBetweenInitializerAndTrailingComma: garbageBetweenInitializerAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `TupleTypeElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct TupleType: TypeBuildable, ExpressibleAsTupleType {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndElements: GarbageNodes?
  let elements: TupleTypeElementList
  let garbageBetweenElementsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndElements: 
  ///   - elements: 
  ///   - garbageBetweenElementsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsTupleTypeElementList,
    garbageBetweenElementsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndElements = garbageBetweenLeftParenAndElements?.createGarbageNodes()
    self.elements = elements.createTupleTypeElementList()
    self.garbageBetweenElementsAndRightParen = garbageBetweenElementsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `TupleTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleTypeSyntax`.
  func buildTupleType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleTypeSyntax {
    let result = SyntaxFactory.makeTupleType(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      garbageBetweenElementsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildTupleType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsTupleType`.
  public func createTupleType() -> TupleType {
    return self
  }

  /// `TupleType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `TupleType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct FunctionType: TypeBuildable, ExpressibleAsFunctionType {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndArguments: GarbageNodes?
  let arguments: TupleTypeElementList
  let garbageBetweenArgumentsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax
  let garbageBetweenRightParenAndAsyncKeyword: GarbageNodes?
  let asyncKeyword: TokenSyntax?
  let garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodes?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let garbageBetweenThrowsOrRethrowsKeywordAndArrow: GarbageNodes?
  let arrow: TokenSyntax
  let garbageBetweenArrowAndReturnType: GarbageNodes?
  let returnType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndArguments: 
  ///   - arguments: 
  ///   - garbageBetweenArgumentsAndRightParen: 
  ///   - rightParen: 
  ///   - garbageBetweenRightParenAndAsyncKeyword: 
  ///   - asyncKeyword: 
  ///   - garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - garbageBetweenThrowsOrRethrowsKeywordAndArrow: 
  ///   - arrow: 
  ///   - garbageBetweenArrowAndReturnType: 
  ///   - returnType: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsTupleTypeElementList,
    garbageBetweenArgumentsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    garbageBetweenRightParenAndAsyncKeyword: ExpressibleAsGarbageNodes? = nil,
    asyncKeyword: TokenSyntax? = nil,
    garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: ExpressibleAsGarbageNodes? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    garbageBetweenThrowsOrRethrowsKeywordAndArrow: ExpressibleAsGarbageNodes? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    garbageBetweenArrowAndReturnType: ExpressibleAsGarbageNodes? = nil,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndArguments = garbageBetweenLeftParenAndArguments?.createGarbageNodes()
    self.arguments = arguments.createTupleTypeElementList()
    self.garbageBetweenArgumentsAndRightParen = garbageBetweenArgumentsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
    self.garbageBetweenRightParenAndAsyncKeyword = garbageBetweenRightParenAndAsyncKeyword?.createGarbageNodes()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword = garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.createGarbageNodes()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || throwsOrRethrowsKeyword!.text == "throws" || throwsOrRethrowsKeyword!.text == "rethrows" || throwsOrRethrowsKeyword!.text == "throw")
    self.garbageBetweenThrowsOrRethrowsKeywordAndArrow = garbageBetweenThrowsOrRethrowsKeywordAndArrow?.createGarbageNodes()
    self.arrow = arrow
    assert(arrow.text == "->")
    self.garbageBetweenArrowAndReturnType = garbageBetweenArrowAndReturnType?.createGarbageNodes()
    self.returnType = returnType.createTypeBuildable()
  }


  /// Builds a `FunctionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionTypeSyntax`.
  func buildFunctionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionTypeSyntax {
    let result = SyntaxFactory.makeFunctionType(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      garbageBetweenRightParenAndAsyncKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      garbageBetweenThrowsOrRethrowsKeywordAndArrow?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arrow: arrow,
      garbageBetweenArrowAndReturnType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildFunctionType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionType`.
  public func createFunctionType() -> FunctionType {
    return self
  }

  /// `FunctionType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `FunctionType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AttributedType: TypeBuildable, ExpressibleAsAttributedType {
  let garbageBeforeSpecifier: GarbageNodes?
  let specifier: TokenSyntax?
  let garbageBetweenSpecifierAndAttributes: GarbageNodes?
  let attributes: AttributeList?
  let garbageBetweenAttributesAndBaseType: GarbageNodes?
  let baseType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AttributedType` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSpecifier: 
  ///   - specifier: 
  ///   - garbageBetweenSpecifierAndAttributes: 
  ///   - attributes: 
  ///   - garbageBetweenAttributesAndBaseType: 
  ///   - baseType: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSpecifier: ExpressibleAsGarbageNodes? = nil,
    specifier: TokenSyntax? = nil,
    garbageBetweenSpecifierAndAttributes: ExpressibleAsGarbageNodes? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    garbageBetweenAttributesAndBaseType: ExpressibleAsGarbageNodes? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSpecifier = garbageBeforeSpecifier?.createGarbageNodes()
    self.specifier = specifier
    assert(specifier == nil || specifier!.text == "inout" || specifier!.text == "__shared" || specifier!.text == "__owned")
    self.garbageBetweenSpecifierAndAttributes = garbageBetweenSpecifierAndAttributes?.createGarbageNodes()
    self.attributes = attributes?.createAttributeList()
    self.garbageBetweenAttributesAndBaseType = garbageBetweenAttributesAndBaseType?.createGarbageNodes()
    self.baseType = baseType.createTypeBuildable()
  }


  /// Builds a `AttributedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AttributedTypeSyntax`.
  func buildAttributedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AttributedTypeSyntax {
    let result = SyntaxFactory.makeAttributedType(
      garbageBeforeSpecifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      specifier: specifier,
      garbageBetweenSpecifierAndAttributes?.buildGarbageNodes(format: format, leadingTrivia: nil),
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      garbageBetweenAttributesAndBaseType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildAttributedType(format: format, leadingTrivia: additionalLeadingTrivia)
    return TypeSyntax(result)
  }

  /// Conformance to `ExpressibleAsAttributedType`.
  public func createAttributedType() -> AttributedType {
    return self
  }

  /// `AttributedType` might conform to `ExpressibleAsTypeBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createTypeBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createTypeBuildable() -> TypeBuildable {
    return self
  }

  /// `AttributedType` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct GenericArgument: SyntaxBuildable, ExpressibleAsGenericArgument, HasTrailingComma {
  let garbageBeforeArgumentType: GarbageNodes?
  let argumentType: TypeBuildable
  let garbageBetweenArgumentTypeAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeArgumentType: 
  ///   - argumentType: 
  ///   - garbageBetweenArgumentTypeAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeArgumentType: ExpressibleAsGarbageNodes? = nil,
    argumentType: ExpressibleAsTypeBuildable,
    garbageBetweenArgumentTypeAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeArgumentType = garbageBeforeArgumentType?.createGarbageNodes()
    self.argumentType = argumentType.createTypeBuildable()
    self.garbageBetweenArgumentTypeAndTrailingComma = garbageBetweenArgumentTypeAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `GenericArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericArgumentSyntax`.
  func buildGenericArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericArgumentSyntax {
    let result = SyntaxFactory.makeGenericArgument(
      garbageBeforeArgumentType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      argumentType: argumentType.buildType(format: format, leadingTrivia: nil),
      garbageBetweenArgumentTypeAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericArgument`.
  public func createGenericArgument() -> GenericArgument {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeArgumentType: garbageBeforeArgumentType,
        argumentType: argumentType,
        garbageBetweenArgumentTypeAndTrailingComma: garbageBetweenArgumentTypeAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `GenericArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct GenericArgumentClause: SyntaxBuildable, ExpressibleAsGenericArgumentClause {
  let garbageBeforeLeftAngleBracket: GarbageNodes?
  let leftAngleBracket: TokenSyntax
  let garbageBetweenLeftAngleBracketAndArguments: GarbageNodes?
  let arguments: GenericArgumentList
  let garbageBetweenArgumentsAndRightAngleBracket: GarbageNodes?
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericArgumentClause` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftAngleBracket: 
  ///   - leftAngleBracket: 
  ///   - garbageBetweenLeftAngleBracketAndArguments: 
  ///   - arguments: 
  ///   - garbageBetweenArgumentsAndRightAngleBracket: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftAngleBracket: ExpressibleAsGarbageNodes? = nil,
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    garbageBetweenLeftAngleBracketAndArguments: ExpressibleAsGarbageNodes? = nil,
    arguments: ExpressibleAsGenericArgumentList,
    garbageBetweenArgumentsAndRightAngleBracket: ExpressibleAsGarbageNodes? = nil,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftAngleBracket = garbageBeforeLeftAngleBracket?.createGarbageNodes()
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.garbageBetweenLeftAngleBracketAndArguments = garbageBetweenLeftAngleBracketAndArguments?.createGarbageNodes()
    self.arguments = arguments.createGenericArgumentList()
    self.garbageBetweenArgumentsAndRightAngleBracket = garbageBetweenArgumentsAndRightAngleBracket?.createGarbageNodes()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftAngleBracket: ExpressibleAsGarbageNodes? = nil,
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    garbageBetweenLeftAngleBracketAndArguments: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenArgumentsAndRightAngleBracket: ExpressibleAsGarbageNodes? = nil,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> ExpressibleAsGenericArgumentList = { GenericArgumentList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftAngleBracket: garbageBeforeLeftAngleBracket,
      leftAngleBracket: leftAngleBracket,
      garbageBetweenLeftAngleBracketAndArguments: garbageBetweenLeftAngleBracketAndArguments,
      arguments: argumentsBuilder(),
      garbageBetweenArgumentsAndRightAngleBracket: garbageBetweenArgumentsAndRightAngleBracket,
      rightAngleBracket: rightAngleBracket
    )
  }

  /// Builds a `GenericArgumentClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericArgumentClauseSyntax`.
  func buildGenericArgumentClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericArgumentClauseSyntax {
    let result = SyntaxFactory.makeGenericArgumentClause(
      garbageBeforeLeftAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftAngleBracket: leftAngleBracket,
      garbageBetweenLeftAngleBracketAndArguments?.buildGarbageNodes(format: format, leadingTrivia: nil),
      arguments: arguments.buildGenericArgumentList(format: format, leadingTrivia: nil),
      garbageBetweenArgumentsAndRightAngleBracket?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericArgumentClause(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericArgumentClause`.
  public func createGenericArgumentClause() -> GenericArgumentClause {
    return self
  }

  /// `GenericArgumentClause` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct TypeAnnotation: SyntaxBuildable, ExpressibleAsTypeAnnotation {
  let garbageBeforeColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndType: GarbageNodes?
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeAnnotation` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeColon: 
  ///   - colon: 
  ///   - garbageBetweenColonAndType: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeColon = garbageBeforeColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndType = garbageBetweenColonAndType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
  }


  /// Builds a `TypeAnnotationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeAnnotationSyntax`.
  func buildTypeAnnotation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeAnnotationSyntax {
    let result = SyntaxFactory.makeTypeAnnotation(
      garbageBeforeColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeAnnotation(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTypeAnnotation`.
  public func createTypeAnnotation() -> TypeAnnotation {
    return self
  }

  /// `TypeAnnotation` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct EnumCasePattern: PatternBuildable, ExpressibleAsEnumCasePattern {
  let garbageBeforeType: GarbageNodes?
  let type: TypeBuildable?
  let garbageBetweenTypeAndPeriod: GarbageNodes?
  let period: TokenSyntax
  let garbageBetweenPeriodAndCaseName: GarbageNodes?
  let caseName: TokenSyntax
  let garbageBetweenCaseNameAndAssociatedTuple: GarbageNodes?
  let associatedTuple: TuplePattern?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCasePattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeType: 
  ///   - type: 
  ///   - garbageBetweenTypeAndPeriod: 
  ///   - period: 
  ///   - garbageBetweenPeriodAndCaseName: 
  ///   - caseName: 
  ///   - garbageBetweenCaseNameAndAssociatedTuple: 
  ///   - associatedTuple: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenTypeAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    garbageBetweenPeriodAndCaseName: ExpressibleAsGarbageNodes? = nil,
    caseName: TokenSyntax,
    garbageBetweenCaseNameAndAssociatedTuple: ExpressibleAsGarbageNodes? = nil,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeType = garbageBeforeType?.createGarbageNodes()
    self.type = type?.createTypeBuildable()
    self.garbageBetweenTypeAndPeriod = garbageBetweenTypeAndPeriod?.createGarbageNodes()
    self.period = period
    assert(period.text == ".")
    self.garbageBetweenPeriodAndCaseName = garbageBetweenPeriodAndCaseName?.createGarbageNodes()
    self.caseName = caseName
    self.garbageBetweenCaseNameAndAssociatedTuple = garbageBetweenCaseNameAndAssociatedTuple?.createGarbageNodes()
    self.associatedTuple = associatedTuple?.createTuplePattern()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    garbageBetweenTypeAndPeriod: ExpressibleAsGarbageNodes? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    garbageBetweenPeriodAndCaseName: ExpressibleAsGarbageNodes? = nil,
    caseName: String,
    garbageBetweenCaseNameAndAssociatedTuple: ExpressibleAsGarbageNodes? = nil,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeType: garbageBeforeType,
      type: type,
      garbageBetweenTypeAndPeriod: garbageBetweenTypeAndPeriod,
      period: period,
      garbageBetweenPeriodAndCaseName: garbageBetweenPeriodAndCaseName,
      caseName: TokenSyntax.identifier(caseName),
      garbageBetweenCaseNameAndAssociatedTuple: garbageBetweenCaseNameAndAssociatedTuple,
      associatedTuple: associatedTuple
    )
  }

  /// Builds a `EnumCasePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCasePatternSyntax`.
  func buildEnumCasePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCasePatternSyntax {
    let result = SyntaxFactory.makeEnumCasePattern(
      garbageBeforeType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type?.buildType(format: format, leadingTrivia: nil),
      garbageBetweenTypeAndPeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      period: period,
      garbageBetweenPeriodAndCaseName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      caseName: caseName,
      garbageBetweenCaseNameAndAssociatedTuple?.buildGarbageNodes(format: format, leadingTrivia: nil),
      associatedTuple: associatedTuple?.buildTuplePattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildEnumCasePattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsEnumCasePattern`.
  public func createEnumCasePattern() -> EnumCasePattern {
    return self
  }

  /// `EnumCasePattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `EnumCasePattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct IsTypePattern: PatternBuildable, ExpressibleAsIsTypePattern {
  let garbageBeforeIsKeyword: GarbageNodes?
  let isKeyword: TokenSyntax
  let garbageBetweenIsKeywordAndType: GarbageNodes?
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIsKeyword: 
  ///   - isKeyword: 
  ///   - garbageBetweenIsKeywordAndType: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIsKeyword: ExpressibleAsGarbageNodes? = nil,
    isKeyword: TokenSyntax = TokenSyntax.`is`,
    garbageBetweenIsKeywordAndType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIsKeyword = garbageBeforeIsKeyword?.createGarbageNodes()
    self.isKeyword = isKeyword
    assert(isKeyword.text == "is")
    self.garbageBetweenIsKeywordAndType = garbageBetweenIsKeywordAndType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
  }


  /// Builds a `IsTypePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IsTypePatternSyntax`.
  func buildIsTypePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IsTypePatternSyntax {
    let result = SyntaxFactory.makeIsTypePattern(
      garbageBeforeIsKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      isKeyword: isKeyword,
      garbageBetweenIsKeywordAndType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildIsTypePattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsIsTypePattern`.
  public func createIsTypePattern() -> IsTypePattern {
    return self
  }

  /// `IsTypePattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `IsTypePattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct OptionalPattern: PatternBuildable, ExpressibleAsOptionalPattern {
  let garbageBeforeSubPattern: GarbageNodes?
  let subPattern: PatternBuildable
  let garbageBetweenSubPatternAndQuestionMark: GarbageNodes?
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalPattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeSubPattern: 
  ///   - subPattern: 
  ///   - garbageBetweenSubPatternAndQuestionMark: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeSubPattern: ExpressibleAsGarbageNodes? = nil,
    subPattern: ExpressibleAsPatternBuildable,
    garbageBetweenSubPatternAndQuestionMark: ExpressibleAsGarbageNodes? = nil,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeSubPattern = garbageBeforeSubPattern?.createGarbageNodes()
    self.subPattern = subPattern.createPatternBuildable()
    self.garbageBetweenSubPatternAndQuestionMark = garbageBetweenSubPatternAndQuestionMark?.createGarbageNodes()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalPatternSyntax`.
  func buildOptionalPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalPatternSyntax {
    let result = SyntaxFactory.makeOptionalPattern(
      garbageBeforeSubPattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      subPattern: subPattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenSubPatternAndQuestionMark?.buildGarbageNodes(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildOptionalPattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsOptionalPattern`.
  public func createOptionalPattern() -> OptionalPattern {
    return self
  }

  /// `OptionalPattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `OptionalPattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct IdentifierPattern: PatternBuildable, ExpressibleAsIdentifierPattern {
  let garbageBeforeIdentifier: GarbageNodes?
  let identifier: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IdentifierPattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeIdentifier: 
  ///   - identifier: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeIdentifier: ExpressibleAsGarbageNodes? = nil,
    identifier: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeIdentifier = garbageBeforeIdentifier?.createGarbageNodes()
    self.identifier = identifier
  }


  /// Builds a `IdentifierPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IdentifierPatternSyntax`.
  func buildIdentifierPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IdentifierPatternSyntax {
    let result = SyntaxFactory.makeIdentifierPattern(
      garbageBeforeIdentifier?.buildGarbageNodes(format: format, leadingTrivia: nil),
      identifier: identifier
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildIdentifierPattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsIdentifierPattern`.
  public func createIdentifierPattern() -> IdentifierPattern {
    return self
  }

  /// `IdentifierPattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `IdentifierPattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct AsTypePattern: PatternBuildable, ExpressibleAsAsTypePattern {
  let garbageBeforePattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndAsKeyword: GarbageNodes?
  let asKeyword: TokenSyntax
  let garbageBetweenAsKeywordAndType: GarbageNodes?
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndAsKeyword: 
  ///   - asKeyword: 
  ///   - garbageBetweenAsKeywordAndType: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndAsKeyword: ExpressibleAsGarbageNodes? = nil,
    asKeyword: TokenSyntax = TokenSyntax.`as`,
    garbageBetweenAsKeywordAndType: ExpressibleAsGarbageNodes? = nil,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePattern = garbageBeforePattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndAsKeyword = garbageBetweenPatternAndAsKeyword?.createGarbageNodes()
    self.asKeyword = asKeyword
    assert(asKeyword.text == "as")
    self.garbageBetweenAsKeywordAndType = garbageBetweenAsKeywordAndType?.createGarbageNodes()
    self.type = type.createTypeBuildable()
  }


  /// Builds a `AsTypePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AsTypePatternSyntax`.
  func buildAsTypePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AsTypePatternSyntax {
    let result = SyntaxFactory.makeAsTypePattern(
      garbageBeforePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndAsKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      asKeyword: asKeyword,
      garbageBetweenAsKeywordAndType?.buildGarbageNodes(format: format, leadingTrivia: nil),
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildAsTypePattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsAsTypePattern`.
  public func createAsTypePattern() -> AsTypePattern {
    return self
  }

  /// `AsTypePattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `AsTypePattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TuplePattern: PatternBuildable, ExpressibleAsTuplePattern {
  let garbageBeforeLeftParen: GarbageNodes?
  let leftParen: TokenSyntax
  let garbageBetweenLeftParenAndElements: GarbageNodes?
  let elements: TuplePatternElementList
  let garbageBetweenElementsAndRightParen: GarbageNodes?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TuplePattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLeftParen: 
  ///   - leftParen: 
  ///   - garbageBetweenLeftParenAndElements: 
  ///   - elements: 
  ///   - garbageBetweenElementsAndRightParen: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElements: ExpressibleAsGarbageNodes? = nil,
    elements: ExpressibleAsTuplePatternElementList,
    garbageBetweenElementsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLeftParen = garbageBeforeLeftParen?.createGarbageNodes()
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.garbageBetweenLeftParenAndElements = garbageBetweenLeftParenAndElements?.createGarbageNodes()
    self.elements = elements.createTuplePatternElementList()
    self.garbageBetweenElementsAndRightParen = garbageBetweenElementsAndRightParen?.createGarbageNodes()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLeftParen: ExpressibleAsGarbageNodes? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    garbageBetweenLeftParenAndElements: ExpressibleAsGarbageNodes? = nil,
    garbageBetweenElementsAndRightParen: ExpressibleAsGarbageNodes? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> ExpressibleAsTuplePatternElementList = { TuplePatternElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLeftParen: garbageBeforeLeftParen,
      leftParen: leftParen,
      garbageBetweenLeftParenAndElements: garbageBetweenLeftParenAndElements,
      elements: elementsBuilder(),
      garbageBetweenElementsAndRightParen: garbageBetweenElementsAndRightParen,
      rightParen: rightParen
    )
  }

  /// Builds a `TuplePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TuplePatternSyntax`.
  func buildTuplePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TuplePatternSyntax {
    let result = SyntaxFactory.makeTuplePattern(
      garbageBeforeLeftParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      garbageBetweenLeftParenAndElements?.buildGarbageNodes(format: format, leadingTrivia: nil),
      elements: elements.buildTuplePatternElementList(format: format, leadingTrivia: nil),
      garbageBetweenElementsAndRightParen?.buildGarbageNodes(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildTuplePattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsTuplePattern`.
  public func createTuplePattern() -> TuplePattern {
    return self
  }

  /// `TuplePattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `TuplePattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct WildcardPattern: PatternBuildable, ExpressibleAsWildcardPattern {
  let garbageBeforeWildcard: GarbageNodes?
  let wildcard: TokenSyntax
  let garbageBetweenWildcardAndTypeAnnotation: GarbageNodes?
  let typeAnnotation: TypeAnnotation?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WildcardPattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeWildcard: 
  ///   - wildcard: 
  ///   - garbageBetweenWildcardAndTypeAnnotation: 
  ///   - typeAnnotation: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeWildcard: ExpressibleAsGarbageNodes? = nil,
    wildcard: TokenSyntax = TokenSyntax.`wildcard`,
    garbageBetweenWildcardAndTypeAnnotation: ExpressibleAsGarbageNodes? = nil,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeWildcard = garbageBeforeWildcard?.createGarbageNodes()
    self.wildcard = wildcard
    assert(wildcard.text == "_")
    self.garbageBetweenWildcardAndTypeAnnotation = garbageBetweenWildcardAndTypeAnnotation?.createGarbageNodes()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
  }


  /// Builds a `WildcardPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WildcardPatternSyntax`.
  func buildWildcardPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WildcardPatternSyntax {
    let result = SyntaxFactory.makeWildcardPattern(
      garbageBeforeWildcard?.buildGarbageNodes(format: format, leadingTrivia: nil),
      wildcard: wildcard,
      garbageBetweenWildcardAndTypeAnnotation?.buildGarbageNodes(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildWildcardPattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsWildcardPattern`.
  public func createWildcardPattern() -> WildcardPattern {
    return self
  }

  /// `WildcardPattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `WildcardPattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct TuplePatternElement: SyntaxBuildable, ExpressibleAsTuplePatternElement, HasTrailingComma {
  let garbageBeforeLabelName: GarbageNodes?
  let labelName: TokenSyntax?
  let garbageBetweenLabelNameAndLabelColon: GarbageNodes?
  let labelColon: TokenSyntax?
  let garbageBetweenLabelColonAndPattern: GarbageNodes?
  let pattern: PatternBuildable
  let garbageBetweenPatternAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TuplePatternElement` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabelName: 
  ///   - labelName: 
  ///   - garbageBetweenLabelNameAndLabelColon: 
  ///   - labelColon: 
  ///   - garbageBetweenLabelColonAndPattern: 
  ///   - pattern: 
  ///   - garbageBetweenPatternAndTrailingComma: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabelName: ExpressibleAsGarbageNodes? = nil,
    labelName: TokenSyntax? = nil,
    garbageBetweenLabelNameAndLabelColon: ExpressibleAsGarbageNodes? = nil,
    labelColon: TokenSyntax? = nil,
    garbageBetweenLabelColonAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabelName = garbageBeforeLabelName?.createGarbageNodes()
    self.labelName = labelName
    self.garbageBetweenLabelNameAndLabelColon = garbageBetweenLabelNameAndLabelColon?.createGarbageNodes()
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.garbageBetweenLabelColonAndPattern = garbageBetweenLabelColonAndPattern?.createGarbageNodes()
    self.pattern = pattern.createPatternBuildable()
    self.garbageBetweenPatternAndTrailingComma = garbageBetweenPatternAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabelName: ExpressibleAsGarbageNodes? = nil,
    labelName: String?,
    garbageBetweenLabelNameAndLabelColon: ExpressibleAsGarbageNodes? = nil,
    labelColon: TokenSyntax? = nil,
    garbageBetweenLabelColonAndPattern: ExpressibleAsGarbageNodes? = nil,
    pattern: ExpressibleAsPatternBuildable,
    garbageBetweenPatternAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabelName: garbageBeforeLabelName,
      labelName: labelName.map(TokenSyntax.identifier),
      garbageBetweenLabelNameAndLabelColon: garbageBetweenLabelNameAndLabelColon,
      labelColon: labelColon,
      garbageBetweenLabelColonAndPattern: garbageBetweenLabelColonAndPattern,
      pattern: pattern,
      garbageBetweenPatternAndTrailingComma: garbageBetweenPatternAndTrailingComma,
      trailingComma: trailingComma
    )
  }

  /// Builds a `TuplePatternElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TuplePatternElementSyntax`.
  func buildTuplePatternElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TuplePatternElementSyntax {
    let result = SyntaxFactory.makeTuplePatternElement(
      garbageBeforeLabelName?.buildGarbageNodes(format: format, leadingTrivia: nil),
      labelName: labelName,
      garbageBetweenLabelNameAndLabelColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      labelColon: labelColon,
      garbageBetweenLabelColonAndPattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      garbageBetweenPatternAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTuplePatternElement(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTuplePatternElement`.
  public func createTuplePatternElement() -> TuplePatternElement {
    return self
  }

  /// Conformance to `HasTrailingComma`.
  public func withTrailingComma(_ withComma: Bool) -> Self {
      return Self.init(
        garbageBeforeLabelName: garbageBeforeLabelName,
        labelName: labelName,
        garbageBetweenLabelNameAndLabelColon: garbageBetweenLabelNameAndLabelColon,
        labelColon: labelColon,
        garbageBetweenLabelColonAndPattern: garbageBetweenLabelColonAndPattern,
        pattern: pattern,
        garbageBetweenPatternAndTrailingComma: garbageBetweenPatternAndTrailingComma,
        trailingComma: withComma ? .comma : nil
      )
  }

  /// `TuplePatternElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ExpressionPattern: PatternBuildable, ExpressibleAsExpressionPattern {
  let garbageBeforeExpression: GarbageNodes?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionPattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeExpression: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeExpression: ExpressibleAsGarbageNodes? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeExpression = garbageBeforeExpression?.createGarbageNodes()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ExpressionPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionPatternSyntax`.
  func buildExpressionPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionPatternSyntax {
    let result = SyntaxFactory.makeExpressionPattern(
      garbageBeforeExpression?.buildGarbageNodes(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildExpressionPattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsExpressionPattern`.
  public func createExpressionPattern() -> ExpressionPattern {
    return self
  }

  /// `ExpressionPattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `ExpressionPattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
public struct ValueBindingPattern: PatternBuildable, ExpressibleAsValueBindingPattern {
  let garbageBeforeLetOrVarKeyword: GarbageNodes?
  let letOrVarKeyword: TokenSyntax
  let garbageBetweenLetOrVarKeywordAndValuePattern: GarbageNodes?
  let valuePattern: PatternBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ValueBindingPattern` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLetOrVarKeyword: 
  ///   - letOrVarKeyword: 
  ///   - garbageBetweenLetOrVarKeywordAndValuePattern: 
  ///   - valuePattern: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLetOrVarKeyword: ExpressibleAsGarbageNodes? = nil,
    letOrVarKeyword: TokenSyntax,
    garbageBetweenLetOrVarKeywordAndValuePattern: ExpressibleAsGarbageNodes? = nil,
    valuePattern: ExpressibleAsPatternBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLetOrVarKeyword = garbageBeforeLetOrVarKeyword?.createGarbageNodes()
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.garbageBetweenLetOrVarKeywordAndValuePattern = garbageBetweenLetOrVarKeywordAndValuePattern?.createGarbageNodes()
    self.valuePattern = valuePattern.createPatternBuildable()
  }


  /// Builds a `ValueBindingPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ValueBindingPatternSyntax`.
  func buildValueBindingPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ValueBindingPatternSyntax {
    let result = SyntaxFactory.makeValueBindingPattern(
      garbageBeforeLetOrVarKeyword?.buildGarbageNodes(format: format, leadingTrivia: nil),
      letOrVarKeyword: letOrVarKeyword,
      garbageBetweenLetOrVarKeywordAndValuePattern?.buildGarbageNodes(format: format, leadingTrivia: nil),
      valuePattern: valuePattern.buildPattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildValueBindingPattern(format: format, leadingTrivia: additionalLeadingTrivia)
    return PatternSyntax(result)
  }

  /// Conformance to `ExpressibleAsValueBindingPattern`.
  public func createValueBindingPattern() -> ValueBindingPattern {
    return self
  }

  /// `ValueBindingPattern` might conform to `ExpressibleAsPatternBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createPatternBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createPatternBuildable() -> PatternBuildable {
    return self
  }

  /// `ValueBindingPattern` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,or `message: "This has been deprecated"`.
public struct AvailabilityArgument: SyntaxBuildable, ExpressibleAsAvailabilityArgument {
  let garbageBeforeEntry: GarbageNodes?
  let entry: SyntaxBuildable
  let garbageBetweenEntryAndTrailingComma: GarbageNodes?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeEntry: 
  ///   - entry: The actual argument
  ///   - garbageBetweenEntryAndTrailingComma: 
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeEntry: ExpressibleAsGarbageNodes? = nil,
    entry: ExpressibleAsSyntaxBuildable,
    garbageBetweenEntryAndTrailingComma: ExpressibleAsGarbageNodes? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeEntry = garbageBeforeEntry?.createGarbageNodes()
    self.entry = entry.createSyntaxBuildable()
    self.garbageBetweenEntryAndTrailingComma = garbageBetweenEntryAndTrailingComma?.createGarbageNodes()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `AvailabilityArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityArgumentSyntax`.
  func buildAvailabilityArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityArgument(
      garbageBeforeEntry?.buildGarbageNodes(format: format, leadingTrivia: nil),
      entry: entry.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenEntryAndTrailingComma?.buildGarbageNodes(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAvailabilityArgument`.
  public func createAvailabilityArgument() -> AvailabilityArgument {
    return self
  }

  /// `AvailabilityArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A argument to an `@available` attribute that consists of a label anda value, e.g. `message: "This has been deprecated"`.
public struct AvailabilityLabeledArgument: SyntaxBuildable, ExpressibleAsAvailabilityLabeledArgument {
  let garbageBeforeLabel: GarbageNodes?
  let label: TokenSyntax
  let garbageBetweenLabelAndColon: GarbageNodes?
  let colon: TokenSyntax
  let garbageBetweenColonAndValue: GarbageNodes?
  let value: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityLabeledArgument` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeLabel: 
  ///   - label: The label of the argument
  ///   - garbageBetweenLabelAndColon: 
  ///   - colon: The colon separating label and value
  ///   - garbageBetweenColonAndValue: 
  ///   - value: The value of this labeled argument
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: TokenSyntax,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeLabel = garbageBeforeLabel?.createGarbageNodes()
    self.label = label
    self.garbageBetweenLabelAndColon = garbageBetweenLabelAndColon?.createGarbageNodes()
    self.colon = colon
    assert(colon.text == ":")
    self.garbageBetweenColonAndValue = garbageBetweenColonAndValue?.createGarbageNodes()
    self.value = value.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeLabel: ExpressibleAsGarbageNodes? = nil,
    label: String,
    garbageBetweenLabelAndColon: ExpressibleAsGarbageNodes? = nil,
    colon: TokenSyntax = TokenSyntax.`colon`,
    garbageBetweenColonAndValue: ExpressibleAsGarbageNodes? = nil,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeLabel: garbageBeforeLabel,
      label: TokenSyntax.identifier(label),
      garbageBetweenLabelAndColon: garbageBetweenLabelAndColon,
      colon: colon,
      garbageBetweenColonAndValue: garbageBetweenColonAndValue,
      value: value
    )
  }

  /// Builds a `AvailabilityLabeledArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityLabeledArgumentSyntax`.
  func buildAvailabilityLabeledArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityLabeledArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityLabeledArgument(
      garbageBeforeLabel?.buildGarbageNodes(format: format, leadingTrivia: nil),
      label: label,
      garbageBetweenLabelAndColon?.buildGarbageNodes(format: format, leadingTrivia: nil),
      colon: colon,
      garbageBetweenColonAndValue?.buildGarbageNodes(format: format, leadingTrivia: nil),
      value: value.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityLabeledArgument(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAvailabilityLabeledArgument`.
  public func createAvailabilityLabeledArgument() -> AvailabilityLabeledArgument {
    return self
  }

  /// `AvailabilityLabeledArgument` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// An argument to `@available` that restricts the availability on acertain platform to a version, e.g. `iOS 10` or `swift 3.4`.
public struct AvailabilityVersionRestriction: SyntaxBuildable, ExpressibleAsAvailabilityVersionRestriction {
  let garbageBeforePlatform: GarbageNodes?
  let platform: TokenSyntax
  let garbageBetweenPlatformAndVersion: GarbageNodes?
  let version: VersionTuple?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityVersionRestriction` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforePlatform: 
  ///   - platform: The name of the OS on which the availability should berestricted or 'swift' if the availability should berestricted based on a Swift version.
  ///   - garbageBetweenPlatformAndVersion: 
  ///   - version: 
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePlatform: ExpressibleAsGarbageNodes? = nil,
    platform: TokenSyntax,
    garbageBetweenPlatformAndVersion: ExpressibleAsGarbageNodes? = nil,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforePlatform = garbageBeforePlatform?.createGarbageNodes()
    self.platform = platform
    self.garbageBetweenPlatformAndVersion = garbageBetweenPlatformAndVersion?.createGarbageNodes()
    self.version = version?.createVersionTuple()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforePlatform: ExpressibleAsGarbageNodes? = nil,
    platform: String,
    garbageBetweenPlatformAndVersion: ExpressibleAsGarbageNodes? = nil,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforePlatform: garbageBeforePlatform,
      platform: TokenSyntax.identifier(platform),
      garbageBetweenPlatformAndVersion: garbageBetweenPlatformAndVersion,
      version: version
    )
  }

  /// Builds a `AvailabilityVersionRestrictionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityVersionRestrictionSyntax`.
  func buildAvailabilityVersionRestriction(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityVersionRestrictionSyntax {
    let result = SyntaxFactory.makeAvailabilityVersionRestriction(
      garbageBeforePlatform?.buildGarbageNodes(format: format, leadingTrivia: nil),
      platform: platform,
      garbageBetweenPlatformAndVersion?.buildGarbageNodes(format: format, leadingTrivia: nil),
      version: version?.buildVersionTuple(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityVersionRestriction(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsAvailabilityVersionRestriction`.
  public func createAvailabilityVersionRestriction() -> AvailabilityVersionRestriction {
    return self
  }

  /// `AvailabilityVersionRestriction` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A version number of the form major.minor.patch in which the minorand patch part may be omitted.
public struct VersionTuple: SyntaxBuildable, ExpressibleAsVersionTuple {
  let garbageBeforeMajorMinor: GarbageNodes?
  let majorMinor: SyntaxBuildable
  let garbageBetweenMajorMinorAndPatchPeriod: GarbageNodes?
  let patchPeriod: TokenSyntax?
  let garbageBetweenPatchPeriodAndPatchVersion: GarbageNodes?
  let patchVersion: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `VersionTuple` using the provided parameters.
  /// - Parameters:
  ///   - garbageBeforeMajorMinor: 
  ///   - majorMinor: In case the version consists only of the major version, aninteger literal that specifies the major version. In casethe version consists of major and minor version number, afloating literal in which the decimal part is interpretedas the minor version.
  ///   - garbageBetweenMajorMinorAndPatchPeriod: 
  ///   - patchPeriod: If the version contains a patch number, the periodseparating the minor from the patch number.
  ///   - garbageBetweenPatchPeriodAndPatchVersion: 
  ///   - patchVersion: The patch version if specified.
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeMajorMinor: ExpressibleAsGarbageNodes? = nil,
    majorMinor: ExpressibleAsSyntaxBuildable,
    garbageBetweenMajorMinorAndPatchPeriod: ExpressibleAsGarbageNodes? = nil,
    patchPeriod: TokenSyntax? = nil,
    garbageBetweenPatchPeriodAndPatchVersion: ExpressibleAsGarbageNodes? = nil,
    patchVersion: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.garbageBeforeMajorMinor = garbageBeforeMajorMinor?.createGarbageNodes()
    self.majorMinor = majorMinor.createSyntaxBuildable()
    self.garbageBetweenMajorMinorAndPatchPeriod = garbageBetweenMajorMinorAndPatchPeriod?.createGarbageNodes()
    self.patchPeriod = patchPeriod
    assert(patchPeriod == nil || patchPeriod!.text == ".")
    self.garbageBetweenPatchPeriodAndPatchVersion = garbageBetweenPatchPeriodAndPatchVersion?.createGarbageNodes()
    self.patchVersion = patchVersion
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    garbageBeforeMajorMinor: ExpressibleAsGarbageNodes? = nil,
    majorMinor: ExpressibleAsSyntaxBuildable,
    garbageBetweenMajorMinorAndPatchPeriod: ExpressibleAsGarbageNodes? = nil,
    patchPeriod: TokenSyntax? = nil,
    garbageBetweenPatchPeriodAndPatchVersion: ExpressibleAsGarbageNodes? = nil,
    patchVersion: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      garbageBeforeMajorMinor: garbageBeforeMajorMinor,
      majorMinor: majorMinor,
      garbageBetweenMajorMinorAndPatchPeriod: garbageBetweenMajorMinorAndPatchPeriod,
      patchPeriod: patchPeriod,
      garbageBetweenPatchPeriodAndPatchVersion: garbageBetweenPatchPeriodAndPatchVersion,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }

  /// Builds a `VersionTupleSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `VersionTupleSyntax`.
  func buildVersionTuple(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> VersionTupleSyntax {
    let result = SyntaxFactory.makeVersionTuple(
      garbageBeforeMajorMinor?.buildGarbageNodes(format: format, leadingTrivia: nil),
      majorMinor: majorMinor.buildSyntax(format: format, leadingTrivia: nil),
      garbageBetweenMajorMinorAndPatchPeriod?.buildGarbageNodes(format: format, leadingTrivia: nil),
      patchPeriod: patchPeriod,
      garbageBetweenPatchPeriodAndPatchVersion?.buildGarbageNodes(format: format, leadingTrivia: nil),
      patchVersion: patchVersion
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia.addingSpacingAfterNewlinesIfNeeded())
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildVersionTuple(format: format, leadingTrivia: additionalLeadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsVersionTuple`.
  public func createVersionTuple() -> VersionTuple {
    return self
  }

  /// `VersionTuple` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
