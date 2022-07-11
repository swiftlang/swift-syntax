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
  let item: SyntaxBuildable
  let semicolon: TokenSyntax?
  let errorTokens: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CodeBlockItem` using the provided parameters.
  /// - Parameters:
  ///   - item: The underlying node inside the code block.
  ///   - semicolon: If present, the trailing semicolon at the end of the item.
  ///   - errorTokens: 
  public init(
    leadingTrivia: Trivia = [],
    item: ExpressibleAsSyntaxBuildable,
    semicolon: TokenSyntax? = nil,
    errorTokens: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.item = item.createSyntaxBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
    self.errorTokens = errorTokens?.createSyntaxBuildable()
  }


  /// Builds a `CodeBlockItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CodeBlockItemSyntax`.
  func buildCodeBlockItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CodeBlockItemSyntax {
    let result = SyntaxFactory.makeCodeBlockItem(
      item: item.buildSyntax(format: format, leadingTrivia: nil),
      semicolon: semicolon,
      errorTokens: errorTokens?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftBrace: TokenSyntax
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CodeBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftBrace: leftBrace,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }

  /// Builds a `CodeBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CodeBlockSyntax`.
  func buildCodeBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CodeBlockSyntax {
    let result = SyntaxFactory.makeCodeBlock(
      leftBrace: leftBrace,
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let ampersand: TokenSyntax
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InOutExpr` using the provided parameters.
  /// - Parameters:
  ///   - ampersand: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    ampersand: TokenSyntax = TokenSyntax.`prefixAmpersand`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.ampersand = ampersand
    assert(ampersand.text == "&")
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `InOutExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InOutExprSyntax`.
  func buildInOutExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InOutExprSyntax {
    let result = SyntaxFactory.makeInOutExpr(
      ampersand: ampersand,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundColumn: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundColumnExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundColumn: 
  public init(
    leadingTrivia: Trivia = [],
    poundColumn: TokenSyntax = TokenSyntax.`poundColumn`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundColumn = poundColumn
    assert(poundColumn.text == "#column")
  }


  /// Builds a `PoundColumnExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundColumnExprSyntax`.
  func buildPoundColumnExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundColumnExprSyntax {
    let result = SyntaxFactory.makePoundColumnExpr(
      poundColumn: poundColumn
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let tryKeyword: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TryExpr` using the provided parameters.
  /// - Parameters:
  ///   - tryKeyword: 
  ///   - questionOrExclamationMark: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    tryKeyword: TokenSyntax = TokenSyntax.`try`,
    questionOrExclamationMark: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.tryKeyword = tryKeyword
    assert(tryKeyword.text == "try")
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `TryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TryExprSyntax`.
  func buildTryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TryExprSyntax {
    let result = SyntaxFactory.makeTryExpr(
      tryKeyword: tryKeyword,
      questionOrExclamationMark: questionOrExclamationMark,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let awaitKeyword: TokenSyntax
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AwaitExpr` using the provided parameters.
  /// - Parameters:
  ///   - awaitKeyword: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    awaitKeyword: TokenSyntax,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword.text == "await")
    self.expression = expression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    awaitKeyword: String,
    expression: ExpressibleAsExprBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      awaitKeyword: TokenSyntax.identifier(awaitKeyword),
      expression: expression
    )
  }

  /// Builds a `AwaitExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AwaitExprSyntax`.
  func buildAwaitExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AwaitExprSyntax {
    let result = SyntaxFactory.makeAwaitExpr(
      awaitKeyword: awaitKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct DeclNameArgument: SyntaxBuildable, ExpressibleAsDeclNameArgument {
  let name: TokenSyntax
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclNameArgument` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.colon = colon
    assert(colon.text == ":")
  }


  /// Builds a `DeclNameArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameArgumentSyntax`.
  func buildDeclNameArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameArgumentSyntax {
    let result = SyntaxFactory.makeDeclNameArgument(
      name: name,
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let arguments: DeclNameArgumentList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclNameArguments` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsDeclNameArgumentList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.arguments = arguments.createDeclNameArgumentList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `DeclNameArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameArgumentsSyntax`.
  func buildDeclNameArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameArgumentsSyntax {
    let result = SyntaxFactory.makeDeclNameArguments(
      leftParen: leftParen,
      arguments: arguments.buildDeclNameArgumentList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IdentifierExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - declNameArguments: 
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `IdentifierExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IdentifierExprSyntax`.
  func buildIdentifierExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IdentifierExprSyntax {
    let result = SyntaxFactory.makeIdentifierExpr(
      identifier: identifier,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let superKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SuperRefExpr` using the provided parameters.
  /// - Parameters:
  ///   - superKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    superKeyword: TokenSyntax = TokenSyntax.`super`
  ) {
    self.leadingTrivia = leadingTrivia
    self.superKeyword = superKeyword
    assert(superKeyword.text == "super")
  }


  /// Builds a `SuperRefExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SuperRefExprSyntax`.
  func buildSuperRefExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SuperRefExprSyntax {
    let result = SyntaxFactory.makeSuperRefExpr(
      superKeyword: superKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let nilKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `NilLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - nilKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    nilKeyword: TokenSyntax = TokenSyntax.`nil`
  ) {
    self.leadingTrivia = leadingTrivia
    self.nilKeyword = nilKeyword
    assert(nilKeyword.text == "nil")
  }


  /// Builds a `NilLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `NilLiteralExprSyntax`.
  func buildNilLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> NilLiteralExprSyntax {
    let result = SyntaxFactory.makeNilLiteralExpr(
      nilKeyword: nilKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let wildcard: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DiscardAssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  public init(
    leadingTrivia: Trivia = [],
    wildcard: TokenSyntax = TokenSyntax.`wildcard`
  ) {
    self.leadingTrivia = leadingTrivia
    self.wildcard = wildcard
    assert(wildcard.text == "_")
  }


  /// Builds a `DiscardAssignmentExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DiscardAssignmentExprSyntax`.
  func buildDiscardAssignmentExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DiscardAssignmentExprSyntax {
    let result = SyntaxFactory.makeDiscardAssignmentExpr(
      wildcard: wildcard
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let assignToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - assignToken: 
  public init(
    leadingTrivia: Trivia = [],
    assignToken: TokenSyntax = TokenSyntax.`equal`
  ) {
    self.leadingTrivia = leadingTrivia
    self.assignToken = assignToken
    assert(assignToken.text == "=")
  }


  /// Builds a `AssignmentExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AssignmentExprSyntax`.
  func buildAssignmentExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AssignmentExprSyntax {
    let result = SyntaxFactory.makeAssignmentExpr(
      assignToken: assignToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let elements: ExprList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SequenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    elements: ExpressibleAsExprList
  ) {
    self.leadingTrivia = leadingTrivia
    self.elements = elements.createExprList()
  }


  /// Builds a `SequenceExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SequenceExprSyntax`.
  func buildSequenceExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SequenceExprSyntax {
    let result = SyntaxFactory.makeSequenceExpr(
      elements: elements.buildExprList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundLine: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundLineExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundLine: 
  public init(
    leadingTrivia: Trivia = [],
    poundLine: TokenSyntax = TokenSyntax.`poundLine`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundLine = poundLine
    assert(poundLine.text == "#line")
  }


  /// Builds a `PoundLineExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundLineExprSyntax`.
  func buildPoundLineExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundLineExprSyntax {
    let result = SyntaxFactory.makePoundLineExpr(
      poundLine: poundLine
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundFile: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFileExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFile: 
  public init(
    leadingTrivia: Trivia = [],
    poundFile: TokenSyntax = TokenSyntax.`poundFile`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundFile = poundFile
    assert(poundFile.text == "#file")
  }


  /// Builds a `PoundFileExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFileExprSyntax`.
  func buildPoundFileExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFileExprSyntax {
    let result = SyntaxFactory.makePoundFileExpr(
      poundFile: poundFile
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundFileID: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFileIDExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFileID: 
  public init(
    leadingTrivia: Trivia = [],
    poundFileID: TokenSyntax = TokenSyntax.`poundFileID`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundFileID = poundFileID
    assert(poundFileID.text == "#fileID")
  }


  /// Builds a `PoundFileIDExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFileIDExprSyntax`.
  func buildPoundFileIDExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFileIDExprSyntax {
    let result = SyntaxFactory.makePoundFileIDExpr(
      poundFileID: poundFileID
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundFilePath: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFilePathExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFilePath: 
  public init(
    leadingTrivia: Trivia = [],
    poundFilePath: TokenSyntax = TokenSyntax.`poundFilePath`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundFilePath = poundFilePath
    assert(poundFilePath.text == "#filePath")
  }


  /// Builds a `PoundFilePathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFilePathExprSyntax`.
  func buildPoundFilePathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFilePathExprSyntax {
    let result = SyntaxFactory.makePoundFilePathExpr(
      poundFilePath: poundFilePath
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundFunction: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundFunctionExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFunction: 
  public init(
    leadingTrivia: Trivia = [],
    poundFunction: TokenSyntax = TokenSyntax.`poundFunction`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundFunction = poundFunction
    assert(poundFunction.text == "#function")
  }


  /// Builds a `PoundFunctionExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundFunctionExprSyntax`.
  func buildPoundFunctionExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundFunctionExprSyntax {
    let result = SyntaxFactory.makePoundFunctionExpr(
      poundFunction: poundFunction
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundDsohandle: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundDsohandleExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundDsohandle: 
  public init(
    leadingTrivia: Trivia = [],
    poundDsohandle: TokenSyntax = TokenSyntax.`poundDsohandle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundDsohandle = poundDsohandle
    assert(poundDsohandle.text == "#dsohandle")
  }


  /// Builds a `PoundDsohandleExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundDsohandleExprSyntax`.
  func buildPoundDsohandleExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundDsohandleExprSyntax {
    let result = SyntaxFactory.makePoundDsohandleExpr(
      poundDsohandle: poundDsohandle
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SymbolicReferenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    identifier: String,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      identifier: TokenSyntax.identifier(identifier),
      genericArgumentClause: genericArgumentClause
    )
  }

  /// Builds a `SymbolicReferenceExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SymbolicReferenceExprSyntax`.
  func buildSymbolicReferenceExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SymbolicReferenceExprSyntax {
    let result = SyntaxFactory.makeSymbolicReferenceExpr(
      identifier: identifier,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let operatorToken: TokenSyntax?
  let postfixExpression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrefixOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
  ///   - postfixExpression: 
  public init(
    leadingTrivia: Trivia = [],
    operatorToken: TokenSyntax? = nil,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.operatorToken = operatorToken
    self.postfixExpression = postfixExpression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    operatorToken: String?,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      operatorToken: operatorToken.map(TokenSyntax.prefixOperator),
      postfixExpression: postfixExpression
    )
  }

  /// Builds a `PrefixOperatorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrefixOperatorExprSyntax`.
  func buildPrefixOperatorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrefixOperatorExprSyntax {
    let result = SyntaxFactory.makePrefixOperatorExpr(
      operatorToken: operatorToken,
      postfixExpression: postfixExpression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let operatorToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BinaryOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
  public init(
    leadingTrivia: Trivia = [],
    operatorToken: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.operatorToken = operatorToken
  }


  /// Builds a `BinaryOperatorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BinaryOperatorExprSyntax`.
  func buildBinaryOperatorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BinaryOperatorExprSyntax {
    let result = SyntaxFactory.makeBinaryOperatorExpr(
      operatorToken: operatorToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let asyncKeyword: TokenSyntax?
  let throwsToken: TokenSyntax?
  let arrowToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrowExpr` using the provided parameters.
  /// - Parameters:
  ///   - asyncKeyword: 
  ///   - throwsToken: 
  ///   - arrowToken: 
  public init(
    leadingTrivia: Trivia = [],
    asyncKeyword: TokenSyntax? = nil,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.leadingTrivia = leadingTrivia
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.throwsToken = throwsToken
    assert(throwsToken == nil || throwsToken!.text == "throws")
    self.arrowToken = arrowToken
    assert(arrowToken.text == "->")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    asyncKeyword: String?,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
  }

  /// Builds a `ArrowExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrowExprSyntax`.
  func buildArrowExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrowExprSyntax {
    let result = SyntaxFactory.makeArrowExpr(
      asyncKeyword: asyncKeyword,
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct FloatLiteralExpr: ExprBuildable, ExpressibleAsFloatLiteralExpr {
  let floatingDigits: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FloatLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - floatingDigits: 
  public init(
    leadingTrivia: Trivia = [],
    floatingDigits: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.floatingDigits = floatingDigits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    floatingDigits: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      floatingDigits: TokenSyntax.floatingLiteral(floatingDigits)
    )
  }

  /// Builds a `FloatLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FloatLiteralExprSyntax`.
  func buildFloatLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FloatLiteralExprSyntax {
    let result = SyntaxFactory.makeFloatLiteralExpr(
      floatingDigits: floatingDigits
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let elementList: TupleExprElementList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elementList = elementList.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftParen: leftParen,
      elementList: elementListBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `TupleExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleExprSyntax`.
  func buildTupleExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleExprSyntax {
    let result = SyntaxFactory.makeTupleExpr(
      leftParen: leftParen,
      elementList: elementList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftSquare: TokenSyntax
  let elements: ArrayElementList
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - elements: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elements: ExpressibleAsArrayElementList,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.elements = elements.createArrayElementList()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ExpressibleAsArrayElementList = { ArrayElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftSquare: leftSquare,
      elements: elementsBuilder(),
      rightSquare: rightSquare
    )
  }

  /// Builds a `ArrayExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayExprSyntax`.
  func buildArrayExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayExprSyntax {
    let result = SyntaxFactory.makeArrayExpr(
      leftSquare: leftSquare,
      elements: elements.buildArrayElementList(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftSquare: TokenSyntax
  let content: SyntaxBuildable
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - content: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    content: ExpressibleAsSyntaxBuildable,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.content = content.createSyntaxBuildable()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }


  /// Builds a `DictionaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryExprSyntax`.
  func buildDictionaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryExprSyntax {
    let result = SyntaxFactory.makeDictionaryExpr(
      leftSquare: leftSquare,
      content: content.buildSyntax(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let label: TokenSyntax?
  let colon: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleExprElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `TupleExprElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleExprElementSyntax`.
  func buildTupleExprElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleExprElementSyntax {
    let result = SyntaxFactory.makeTupleExprElement(
      label: label,
      colon: colon,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        label: label,
        colon: colon,
        expression: expression,
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
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayElement` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ArrayElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayElementSyntax`.
  func buildArrayElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayElementSyntax {
    let result = SyntaxFactory.makeArrayElement(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        expression: expression,
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
  let keyExpression: ExprBuildable
  let colon: TokenSyntax
  let valueExpression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryElement` using the provided parameters.
  /// - Parameters:
  ///   - keyExpression: 
  ///   - colon: 
  ///   - valueExpression: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    keyExpression: ExpressibleAsExprBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueExpression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.keyExpression = keyExpression.createExprBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.valueExpression = valueExpression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `DictionaryElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryElementSyntax`.
  func buildDictionaryElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryElementSyntax {
    let result = SyntaxFactory.makeDictionaryElement(
      keyExpression: keyExpression.buildExpr(format: format, leadingTrivia: nil),
      colon: colon,
      valueExpression: valueExpression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        keyExpression: keyExpression,
        colon: colon,
        valueExpression: valueExpression,
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
  let digits: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IntegerLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - digits: 
  public init(
    leadingTrivia: Trivia = [],
    digits: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.digits = digits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    digits: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      digits: TokenSyntax.integerLiteral(digits)
    )
  }

  /// Builds a `IntegerLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IntegerLiteralExprSyntax`.
  func buildIntegerLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IntegerLiteralExprSyntax {
    let result = SyntaxFactory.makeIntegerLiteralExpr(
      digits: digits
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let booleanLiteral: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BooleanLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - booleanLiteral: 
  public init(
    leadingTrivia: Trivia = [],
    booleanLiteral: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.booleanLiteral = booleanLiteral
    assert(booleanLiteral.text == "true" || booleanLiteral.text == "false")
  }


  /// Builds a `BooleanLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BooleanLiteralExprSyntax`.
  func buildBooleanLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BooleanLiteralExprSyntax {
    let result = SyntaxFactory.makeBooleanLiteralExpr(
      booleanLiteral: booleanLiteral
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let conditionExpression: ExprBuildable
  let questionMark: TokenSyntax
  let firstChoice: ExprBuildable
  let colonMark: TokenSyntax
  let secondChoice: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TernaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - conditionExpression: 
  ///   - questionMark: 
  ///   - firstChoice: 
  ///   - colonMark: 
  ///   - secondChoice: 
  public init(
    leadingTrivia: Trivia = [],
    conditionExpression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`infixQuestionMark`,
    firstChoice: ExpressibleAsExprBuildable,
    colonMark: TokenSyntax = TokenSyntax.`colon`,
    secondChoice: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.conditionExpression = conditionExpression.createExprBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
    self.firstChoice = firstChoice.createExprBuildable()
    self.colonMark = colonMark
    assert(colonMark.text == ":")
    self.secondChoice = secondChoice.createExprBuildable()
  }


  /// Builds a `TernaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TernaryExprSyntax`.
  func buildTernaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TernaryExprSyntax {
    let result = SyntaxFactory.makeTernaryExpr(
      conditionExpression: conditionExpression.buildExpr(format: format, leadingTrivia: nil),
      questionMark: questionMark,
      firstChoice: firstChoice.buildExpr(format: format, leadingTrivia: nil),
      colonMark: colonMark,
      secondChoice: secondChoice.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let base: ExprBuildable?
  let dot: TokenSyntax
  let name: TokenSyntax
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberAccessExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - dot: 
  ///   - name: 
  ///   - declNameArguments: 
  public init(
    leadingTrivia: Trivia = [],
    base: ExpressibleAsExprBuildable? = nil,
    dot: TokenSyntax,
    name: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.base = base?.createExprBuildable()
    self.dot = dot
    assert(dot.text == "." || dot.text == ".")
    self.name = name
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `MemberAccessExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberAccessExprSyntax`.
  func buildMemberAccessExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberAccessExprSyntax {
    let result = SyntaxFactory.makeMemberAccessExpr(
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      dot: dot,
      name: name,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let isTok: TokenSyntax
  let typeName: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IsExpr` using the provided parameters.
  /// - Parameters:
  ///   - isTok: 
  ///   - typeName: 
  public init(
    leadingTrivia: Trivia = [],
    isTok: TokenSyntax = TokenSyntax.`is`,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.isTok = isTok
    assert(isTok.text == "is")
    self.typeName = typeName.createTypeBuildable()
  }


  /// Builds a `IsExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IsExprSyntax`.
  func buildIsExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IsExprSyntax {
    let result = SyntaxFactory.makeIsExpr(
      isTok: isTok,
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let asTok: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let typeName: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AsExpr` using the provided parameters.
  /// - Parameters:
  ///   - asTok: 
  ///   - questionOrExclamationMark: 
  ///   - typeName: 
  public init(
    leadingTrivia: Trivia = [],
    asTok: TokenSyntax = TokenSyntax.`as`,
    questionOrExclamationMark: TokenSyntax? = nil,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.asTok = asTok
    assert(asTok.text == "as")
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.typeName = typeName.createTypeBuildable()
  }


  /// Builds a `AsExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AsExprSyntax`.
  func buildAsExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AsExprSyntax {
    let result = SyntaxFactory.makeAsExpr(
      asTok: asTok,
      questionOrExclamationMark: questionOrExclamationMark,
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeExpr` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.type = type.createTypeBuildable()
  }


  /// Builds a `TypeExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeExprSyntax`.
  func buildTypeExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeExprSyntax {
    let result = SyntaxFactory.makeTypeExpr(
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let specifier: TokenList?
  let name: TokenSyntax?
  let assignToken: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureCaptureItem` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - name: 
  ///   - assignToken: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    specifier: ExpressibleAsTokenList? = nil,
    name: TokenSyntax? = nil,
    assignToken: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.specifier = specifier?.createTokenList()
    self.name = name
    self.assignToken = assignToken
    assert(assignToken == nil || assignToken!.text == "=")
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    specifier: ExpressibleAsTokenList? = nil,
    name: String?,
    assignToken: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      specifier: specifier,
      name: name.map(TokenSyntax.identifier),
      assignToken: assignToken,
      expression: expression,
      trailingComma: trailingComma
    )
  }

  /// Builds a `ClosureCaptureItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureCaptureItemSyntax`.
  func buildClosureCaptureItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureCaptureItemSyntax {
    let result = SyntaxFactory.makeClosureCaptureItem(
      specifier: specifier?.buildTokenList(format: format, leadingTrivia: nil),
      name: name,
      assignToken: assignToken,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        specifier: specifier,
        name: name,
        assignToken: assignToken,
        expression: expression,
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
  let leftSquare: TokenSyntax
  let items: ClosureCaptureItemList?
  let rightSquare: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureCaptureSignature` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - items: 
  ///   - rightSquare: 
  public init(
    leadingTrivia: Trivia = [],
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    items: ExpressibleAsClosureCaptureItemList? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.items = items?.createClosureCaptureItemList()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ExpressibleAsClosureCaptureItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftSquare: leftSquare,
      items: itemsBuilder(),
      rightSquare: rightSquare
    )
  }

  /// Builds a `ClosureCaptureSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureCaptureSignatureSyntax`.
  func buildClosureCaptureSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureCaptureSignatureSyntax {
    let result = SyntaxFactory.makeClosureCaptureSignature(
      leftSquare: leftSquare,
      items: items?.buildClosureCaptureItemList(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureParam` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ClosureParamSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureParamSyntax`.
  func buildClosureParam(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureParamSyntax {
    let result = SyntaxFactory.makeClosureParam(
      name: name,
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        name: name,
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
  let attributes: AttributeList?
  let capture: ClosureCaptureSignature?
  let input: SyntaxBuildable?
  let asyncKeyword: TokenSyntax?
  let throwsTok: TokenSyntax?
  let output: ReturnClause?
  let inTok: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureSignature` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - capture: 
  ///   - input: 
  ///   - asyncKeyword: 
  ///   - throwsTok: 
  ///   - output: 
  ///   - inTok: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsTok: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.capture = capture?.createClosureCaptureSignature()
    self.input = input?.createSyntaxBuildable()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.throwsTok = throwsTok
    assert(throwsTok == nil || throwsTok!.text == "throws")
    self.output = output?.createReturnClause()
    self.inTok = inTok
    assert(inTok.text == "in")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: String?,
    throwsTok: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      capture: capture,
      input: input,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsTok: throwsTok,
      output: output,
      inTok: inTok
    )
  }

  /// Builds a `ClosureSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureSignatureSyntax`.
  func buildClosureSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureSignatureSyntax {
    let result = SyntaxFactory.makeClosureSignature(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      capture: capture?.buildClosureCaptureSignature(format: format, leadingTrivia: nil),
      input: input?.buildSyntax(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      throwsTok: throwsTok,
      output: output?.buildReturnClause(format: format, leadingTrivia: nil),
      inTok: inTok
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftBrace: TokenSyntax
  let signature: ClosureSignature?
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClosureExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - signature: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.signature = signature?.createClosureSignature()
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftBrace: leftBrace,
      signature: signature,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }

  /// Builds a `ClosureExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClosureExprSyntax`.
  func buildClosureExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClosureExprSyntax {
    let result = SyntaxFactory.makeClosureExpr(
      leftBrace: leftBrace,
      signature: signature?.buildClosureSignature(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let pattern: PatternBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `UnresolvedPatternExpr` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  public init(
    leadingTrivia: Trivia = [],
    pattern: ExpressibleAsPatternBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.pattern = pattern.createPatternBuildable()
  }


  /// Builds a `UnresolvedPatternExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `UnresolvedPatternExprSyntax`.
  func buildUnresolvedPatternExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> UnresolvedPatternExprSyntax {
    let result = SyntaxFactory.makeUnresolvedPatternExpr(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let label: TokenSyntax
  let colon: TokenSyntax
  let closure: ClosureExpr

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MultipleTrailingClosureElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - closure: 
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    closure: ExpressibleAsClosureExpr
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.closure = closure.createClosureExpr()
  }


  /// Builds a `MultipleTrailingClosureElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MultipleTrailingClosureElementSyntax`.
  func buildMultipleTrailingClosureElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementSyntax {
    let result = SyntaxFactory.makeMultipleTrailingClosureElement(
      label: label,
      colon: colon,
      closure: closure.buildClosureExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let calledExpression: ExprBuildable
  let leftParen: TokenSyntax?
  let argumentList: TupleExprElementList
  let rightParen: TokenSyntax?
  let trailingClosure: ClosureExpr?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionCallExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    leadingTrivia: Trivia = [],
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      calledExpression: calledExpression,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }

  /// Builds a `FunctionCallExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionCallExprSyntax`.
  func buildFunctionCallExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionCallExprSyntax {
    let result = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let calledExpression: ExprBuildable
  let leftBracket: TokenSyntax
  let argumentList: TupleExprElementList
  let rightBracket: TokenSyntax
  let trailingClosure: ClosureExpr?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SubscriptExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftBracket: 
  ///   - argumentList: 
  ///   - rightBracket: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    leadingTrivia: Trivia = [],
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    argumentList: ExpressibleAsTupleExprElementList,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftBracket = leftBracket
    assert(leftBracket.text == "[")
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightBracket = rightBracket
    assert(rightBracket.text == "]")
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      calledExpression: calledExpression,
      leftBracket: leftBracket,
      argumentList: argumentListBuilder(),
      rightBracket: rightBracket,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }

  /// Builds a `SubscriptExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SubscriptExprSyntax`.
  func buildSubscriptExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SubscriptExprSyntax {
    let result = SyntaxFactory.makeSubscriptExpr(
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      leftBracket: leftBracket,
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightBracket: rightBracket,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let expression: ExprBuildable
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalChainingExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalChainingExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalChainingExprSyntax`.
  func buildOptionalChainingExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalChainingExprSyntax {
    let result = SyntaxFactory.makeOptionalChainingExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let expression: ExprBuildable
  let exclamationMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ForcedValueExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - exclamationMark: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  /// Builds a `ForcedValueExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ForcedValueExprSyntax`.
  func buildForcedValueExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ForcedValueExprSyntax {
    let result = SyntaxFactory.makeForcedValueExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let expression: ExprBuildable
  let operatorToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PostfixUnaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - operatorToken: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    operatorToken: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
    self.operatorToken = operatorToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    operatorToken: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      expression: expression,
      operatorToken: TokenSyntax.postfixOperator(operatorToken)
    )
  }

  /// Builds a `PostfixUnaryExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PostfixUnaryExprSyntax`.
  func buildPostfixUnaryExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PostfixUnaryExprSyntax {
    let result = SyntaxFactory.makePostfixUnaryExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      operatorToken: operatorToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let expression: ExprBuildable
  let genericArgumentClause: GenericArgumentClause

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SpecializeExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable,
    genericArgumentClause: ExpressibleAsGenericArgumentClause
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
    self.genericArgumentClause = genericArgumentClause.createGenericArgumentClause()
  }


  /// Builds a `SpecializeExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SpecializeExprSyntax`.
  func buildSpecializeExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SpecializeExprSyntax {
    let result = SyntaxFactory.makeSpecializeExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let content: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StringSegment` using the provided parameters.
  /// - Parameters:
  ///   - content: 
  public init(
    leadingTrivia: Trivia = [],
    content: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.content = content
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    content: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      content: TokenSyntax.stringSegment(content)
    )
  }

  /// Builds a `StringSegmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StringSegmentSyntax`.
  func buildStringSegment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StringSegmentSyntax {
    let result = SyntaxFactory.makeStringSegment(
      content: content
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let backslash: TokenSyntax
  let delimiter: TokenSyntax?
  let leftParen: TokenSyntax
  let expressions: TupleExprElementList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionSegment` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - delimiter: 
  ///   - leftParen: 
  ///   - expressions: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: TokenSyntax? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    expressions: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`
  ) {
    self.leadingTrivia = leadingTrivia
    self.backslash = backslash
    assert(backslash.text == "\\")
    self.delimiter = delimiter
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.expressions = expressions.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: String?,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
    @TupleExprElementListBuilder expressionsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      backslash: backslash,
      delimiter: delimiter.map(TokenSyntax.rawStringDelimiter),
      leftParen: leftParen,
      expressions: expressionsBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `ExpressionSegmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionSegmentSyntax`.
  func buildExpressionSegment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionSegmentSyntax {
    let result = SyntaxFactory.makeExpressionSegment(
      backslash: backslash,
      delimiter: delimiter,
      leftParen: leftParen,
      expressions: expressions.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let openDelimiter: TokenSyntax?
  let openQuote: TokenSyntax
  let segments: StringLiteralSegments
  let closeQuote: TokenSyntax
  let closeDelimiter: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StringLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - openDelimiter: 
  ///   - openQuote: 
  ///   - segments: 
  ///   - closeQuote: 
  ///   - closeDelimiter: 
  public init(
    leadingTrivia: Trivia = [],
    openDelimiter: TokenSyntax? = nil,
    openQuote: TokenSyntax,
    segments: ExpressibleAsStringLiteralSegments,
    closeQuote: TokenSyntax,
    closeDelimiter: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.openDelimiter = openDelimiter
    self.openQuote = openQuote
    assert(openQuote.text == "\"" || openQuote.text == "\"\"\"")
    self.segments = segments.createStringLiteralSegments()
    self.closeQuote = closeQuote
    assert(closeQuote.text == "\"" || closeQuote.text == "\"\"\"")
    self.closeDelimiter = closeDelimiter
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    openDelimiter: String?,
    openQuote: TokenSyntax,
    segments: ExpressibleAsStringLiteralSegments,
    closeQuote: TokenSyntax,
    closeDelimiter: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      openDelimiter: openDelimiter.map(TokenSyntax.rawStringDelimiter),
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter.map(TokenSyntax.rawStringDelimiter)
    )
  }

  /// Builds a `StringLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StringLiteralExprSyntax`.
  func buildStringLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StringLiteralExprSyntax {
    let result = SyntaxFactory.makeStringLiteralExpr(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments.buildStringLiteralSegments(format: format, leadingTrivia: nil),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let regex: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `RegexLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - regex: 
  public init(
    leadingTrivia: Trivia = [],
    regex: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.regex = regex
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    regex: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      regex: TokenSyntax.regexLiteral(regex)
    )
  }

  /// Builds a `RegexLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `RegexLiteralExprSyntax`.
  func buildRegexLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> RegexLiteralExprSyntax {
    let result = SyntaxFactory.makeRegexLiteralExpr(
      regex: regex
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let backslash: TokenSyntax
  let rootExpr: ExprBuildable?
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `KeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - rootExpr: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    rootExpr: ExpressibleAsExprBuildable? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.backslash = backslash
    assert(backslash.text == "\\")
    self.rootExpr = rootExpr?.createExprBuildable()
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `KeyPathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `KeyPathExprSyntax`.
  func buildKeyPathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> KeyPathExprSyntax {
    let result = SyntaxFactory.makeKeyPathExpr(
      backslash: backslash,
      rootExpr: rootExpr?.buildExpr(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let period: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `KeyPathBaseExpr` using the provided parameters.
  /// - Parameters:
  ///   - period: 
  public init(
    leadingTrivia: Trivia = [],
    period: TokenSyntax = TokenSyntax.`period`
  ) {
    self.leadingTrivia = leadingTrivia
    self.period = period
    assert(period.text == ".")
  }


  /// Builds a `KeyPathBaseExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `KeyPathBaseExprSyntax`.
  func buildKeyPathBaseExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> KeyPathBaseExprSyntax {
    let result = SyntaxFactory.makeKeyPathBaseExpr(
      period: period
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let dot: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcNamePiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - dot: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    dot: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.dot = dot
    assert(dot == nil || dot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String,
    dot: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: TokenSyntax.identifier(name),
      dot: dot
    )
  }

  /// Builds a `ObjcNamePieceSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcNamePieceSyntax`.
  func buildObjcNamePiece(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcNamePieceSyntax {
    let result = SyntaxFactory.makeObjcNamePiece(
      name: name,
      dot: dot
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let keyPath: TokenSyntax
  let leftParen: TokenSyntax
  let name: ObjcName
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcKeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - keyPath: 
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: ExpressibleAsObjcName,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.keyPath = keyPath
    assert(keyPath.text == "#keyPath")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.name = name.createObjcName()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `ObjcKeyPathExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcKeyPathExprSyntax`.
  func buildObjcKeyPathExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcKeyPathExprSyntax {
    let result = SyntaxFactory.makeObjcKeyPathExpr(
      keyPath: keyPath,
      leftParen: leftParen,
      name: name.buildObjcName(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundSelector: TokenSyntax
  let leftParen: TokenSyntax
  let kind: TokenSyntax?
  let colon: TokenSyntax?
  let name: ExprBuildable
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjcSelectorExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundSelector: 
  ///   - leftParen: 
  ///   - kind: 
  ///   - colon: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundSelector = poundSelector
    assert(poundSelector.text == "#selector")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.kind = kind
    assert(kind == nil || kind!.text == "getter" || kind!.text == "setter")
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.name = name.createExprBuildable()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: String?,
    colon: TokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      poundSelector: poundSelector,
      leftParen: leftParen,
      kind: kind.map(TokenSyntax.contextualKeyword),
      colon: colon,
      name: name,
      rightParen: rightParen
    )
  }

  /// Builds a `ObjcSelectorExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjcSelectorExprSyntax`.
  func buildObjcSelectorExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjcSelectorExprSyntax {
    let result = SyntaxFactory.makeObjcSelectorExpr(
      poundSelector: poundSelector,
      leftParen: leftParen,
      kind: kind,
      colon: colon,
      name: name.buildExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let base: ExprBuildable?
  let config: IfConfigDecl

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PostfixIfConfigExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - config: 
  public init(
    leadingTrivia: Trivia = [],
    base: ExpressibleAsExprBuildable? = nil,
    config: ExpressibleAsIfConfigDecl
  ) {
    self.leadingTrivia = leadingTrivia
    self.base = base?.createExprBuildable()
    self.config = config.createIfConfigDecl()
  }


  /// Builds a `PostfixIfConfigExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PostfixIfConfigExprSyntax`.
  func buildPostfixIfConfigExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PostfixIfConfigExprSyntax {
    let result = SyntaxFactory.makePostfixIfConfigExpr(
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      config: config.buildIfConfigDecl(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EditorPlaceholderExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    identifier: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      identifier: TokenSyntax.identifier(identifier)
    )
  }

  /// Builds a `EditorPlaceholderExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EditorPlaceholderExprSyntax`.
  func buildEditorPlaceholderExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EditorPlaceholderExprSyntax {
    let result = SyntaxFactory.makeEditorPlaceholderExpr(
      identifier: identifier
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax
  let leftParen: TokenSyntax
  let arguments: TupleExprElementList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjectLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
    assert(identifier.text == "#colorLiteral" || identifier.text == "#fileLiteral" || identifier.text == "#imageLiteral")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.arguments = arguments.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      identifier: identifier,
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `ObjectLiteralExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjectLiteralExprSyntax`.
  func buildObjectLiteralExpr(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjectLiteralExprSyntax {
    let result = SyntaxFactory.makeObjectLiteralExpr(
      identifier: identifier,
      leftParen: leftParen,
      arguments: arguments.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let equal: TokenSyntax
  let value: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeInitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    leadingTrivia: Trivia = [],
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.equal = equal
    assert(equal.text == "=")
    self.value = value.createTypeBuildable()
  }


  /// Builds a `TypeInitializerClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeInitializerClauseSyntax`.
  func buildTypeInitializerClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeInitializerClauseSyntax {
    let result = SyntaxFactory.makeTypeInitializerClause(
      equal: equal,
      value: value.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let typealiasKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let initializer: TypeInitializerClause?
  let genericWhereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypealiasDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - typealiasKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - initializer: 
  ///   - genericWhereClause: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.typealiasKeyword = typealiasKeyword
    assert(typealiasKeyword.text == "typealias")
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.initializer = initializer?.createTypeInitializerClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      typealiasKeyword: typealiasKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }

  /// Builds a `TypealiasDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypealiasDeclSyntax`.
  func buildTypealiasDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypealiasDeclSyntax {
    let result = SyntaxFactory.makeTypealiasDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      typealiasKeyword: typealiasKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let associatedtypeKeyword: TokenSyntax
  let identifier: TokenSyntax
  let inheritanceClause: TypeInheritanceClause?
  let initializer: TypeInitializerClause?
  let genericWhereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AssociatedtypeDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - associatedtypeKeyword: 
  ///   - identifier: 
  ///   - inheritanceClause: 
  ///   - initializer: 
  ///   - genericWhereClause: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: TokenSyntax,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.associatedtypeKeyword = associatedtypeKeyword
    assert(associatedtypeKeyword.text == "associatedtype")
    self.identifier = identifier
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.initializer = initializer?.createTypeInitializerClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: String,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: TokenSyntax.identifier(identifier),
      inheritanceClause: inheritanceClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }

  /// Builds a `AssociatedtypeDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AssociatedtypeDeclSyntax`.
  func buildAssociatedtypeDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AssociatedtypeDeclSyntax {
    let result = SyntaxFactory.makeAssociatedtypeDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: identifier,
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let parameterList: FunctionParameterList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - parameterList: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    parameterList: ExpressibleAsFunctionParameterList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.parameterList = parameterList.createFunctionParameterList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> ExpressibleAsFunctionParameterList = { FunctionParameterList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftParen: leftParen,
      parameterList: parameterListBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `ParameterClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ParameterClauseSyntax`.
  func buildParameterClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ParameterClauseSyntax {
    let result = SyntaxFactory.makeParameterClause(
      leftParen: leftParen,
      parameterList: parameterList.buildFunctionParameterList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ReturnClause` using the provided parameters.
  /// - Parameters:
  ///   - arrow: 
  ///   - returnType: 
  public init(
    leadingTrivia: Trivia = [],
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.arrow = arrow
    assert(arrow.text == "->")
    self.returnType = returnType.createTypeBuildable()
  }


  /// Builds a `ReturnClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ReturnClauseSyntax`.
  func buildReturnClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ReturnClauseSyntax {
    let result = SyntaxFactory.makeReturnClause(
      arrow: arrow,
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let input: ParameterClause
  let asyncOrReasyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let output: ReturnClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionSignature` using the provided parameters.
  /// - Parameters:
  ///   - input: 
  ///   - asyncOrReasyncKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - output: 
  public init(
    leadingTrivia: Trivia = [],
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.input = input.createParameterClause()
    self.asyncOrReasyncKeyword = asyncOrReasyncKeyword
    assert(asyncOrReasyncKeyword == nil || asyncOrReasyncKeyword!.text == "async" || asyncOrReasyncKeyword!.text == "reasync")
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || throwsOrRethrowsKeyword!.text == "throws" || throwsOrRethrowsKeyword!.text == "rethrows")
    self.output = output?.createReturnClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: String?,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      input: input,
      asyncOrReasyncKeyword: asyncOrReasyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output
    )
  }

  /// Builds a `FunctionSignatureSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionSignatureSyntax`.
  func buildFunctionSignature(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionSignatureSyntax {
    let result = SyntaxFactory.makeFunctionSignature(
      input: input.buildParameterClause(format: format, leadingTrivia: nil),
      asyncOrReasyncKeyword: asyncOrReasyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output?.buildReturnClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundKeyword: TokenSyntax
  let condition: ExprBuildable?
  let elements: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfConfigClause` using the provided parameters.
  /// - Parameters:
  ///   - poundKeyword: 
  ///   - condition: 
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    poundKeyword: TokenSyntax,
    condition: ExpressibleAsExprBuildable? = nil,
    elements: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundKeyword = poundKeyword
    assert(poundKeyword.text == "#if" || poundKeyword.text == "#elseif" || poundKeyword.text == "#else")
    self.condition = condition?.createExprBuildable()
    self.elements = elements.createSyntaxBuildable()
  }


  /// Builds a `IfConfigClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfConfigClauseSyntax`.
  func buildIfConfigClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfConfigClauseSyntax {
    let result = SyntaxFactory.makeIfConfigClause(
      poundKeyword: poundKeyword,
      condition: condition?.buildExpr(format: format, leadingTrivia: nil),
      elements: elements.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let clauses: IfConfigClauseList
  let poundEndif: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfConfigDecl` using the provided parameters.
  /// - Parameters:
  ///   - clauses: 
  ///   - poundEndif: 
  public init(
    leadingTrivia: Trivia = [],
    clauses: ExpressibleAsIfConfigClauseList,
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`
  ) {
    self.leadingTrivia = leadingTrivia
    self.clauses = clauses.createIfConfigClauseList()
    self.poundEndif = poundEndif
    assert(poundEndif.text == "#endif")
  }


  /// Builds a `IfConfigDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfConfigDeclSyntax`.
  func buildIfConfigDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfConfigDeclSyntax {
    let result = SyntaxFactory.makeIfConfigDecl(
      clauses: clauses.buildIfConfigClauseList(format: format, leadingTrivia: nil),
      poundEndif: poundEndif
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundError: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundErrorDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundError: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundError: TokenSyntax = TokenSyntax.`poundError`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundError = poundError
    assert(poundError.text == "#error")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundErrorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundErrorDeclSyntax`.
  func buildPoundErrorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundErrorDeclSyntax {
    let result = SyntaxFactory.makePoundErrorDecl(
      poundError: poundError,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundWarning: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundWarningDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundWarning: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundWarning: TokenSyntax = TokenSyntax.`poundWarning`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundWarning = poundWarning
    assert(poundWarning.text == "#warning")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundWarningDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundWarningDeclSyntax`.
  func buildPoundWarningDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundWarningDeclSyntax {
    let result = SyntaxFactory.makePoundWarningDecl(
      poundWarning: poundWarning,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundSourceLocation: TokenSyntax
  let leftParen: TokenSyntax
  let args: PoundSourceLocationArgs?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundSourceLocation` using the provided parameters.
  /// - Parameters:
  ///   - poundSourceLocation: 
  ///   - leftParen: 
  ///   - args: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundSourceLocation: TokenSyntax = TokenSyntax.`poundSourceLocation`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    args: ExpressibleAsPoundSourceLocationArgs? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundSourceLocation = poundSourceLocation
    assert(poundSourceLocation.text == "#sourceLocation")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.args = args?.createPoundSourceLocationArgs()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `PoundSourceLocationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundSourceLocationSyntax`.
  func buildPoundSourceLocation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundSourceLocationSyntax {
    let result = SyntaxFactory.makePoundSourceLocation(
      poundSourceLocation: poundSourceLocation,
      leftParen: leftParen,
      args: args?.buildPoundSourceLocationArgs(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let fileArgLabel: TokenSyntax
  let fileArgColon: TokenSyntax
  let fileName: TokenSyntax
  let comma: TokenSyntax
  let lineArgLabel: TokenSyntax
  let lineArgColon: TokenSyntax
  let lineNumber: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundSourceLocationArgs` using the provided parameters.
  /// - Parameters:
  ///   - fileArgLabel: 
  ///   - fileArgColon: 
  ///   - fileName: 
  ///   - comma: 
  ///   - lineArgLabel: 
  ///   - lineArgColon: 
  ///   - lineNumber: 
  public init(
    leadingTrivia: Trivia = [],
    fileArgLabel: TokenSyntax,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: TokenSyntax,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: TokenSyntax,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.fileArgLabel = fileArgLabel
    assert(fileArgLabel.text == "file")
    self.fileArgColon = fileArgColon
    assert(fileArgColon.text == ":")
    self.fileName = fileName
    self.comma = comma
    assert(comma.text == ",")
    self.lineArgLabel = lineArgLabel
    assert(lineArgLabel.text == "line")
    self.lineArgColon = lineArgColon
    assert(lineArgColon.text == ":")
    self.lineNumber = lineNumber
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    fileArgLabel: String,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: String,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: String,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      fileArgLabel: TokenSyntax.identifier(fileArgLabel),
      fileArgColon: fileArgColon,
      fileName: TokenSyntax.stringLiteral(fileName),
      comma: comma,
      lineArgLabel: TokenSyntax.identifier(lineArgLabel),
      lineArgColon: lineArgColon,
      lineNumber: TokenSyntax.integerLiteral(lineNumber)
    )
  }

  /// Builds a `PoundSourceLocationArgsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundSourceLocationArgsSyntax`.
  func buildPoundSourceLocationArgs(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundSourceLocationArgsSyntax {
    let result = SyntaxFactory.makePoundSourceLocationArgs(
      fileArgLabel: fileArgLabel,
      fileArgColon: fileArgColon,
      fileName: fileName,
      comma: comma,
      lineArgLabel: lineArgLabel,
      lineArgColon: lineArgColon,
      lineNumber: lineNumber
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct DeclModifier: SyntaxBuildable, ExpressibleAsDeclModifier {
  let name: TokenSyntax
  let detailLeftParen: TokenSyntax?
  let detail: TokenSyntax?
  let detailRightParen: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - detailLeftParen: 
  ///   - detail: 
  ///   - detailRightParen: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: TokenSyntax? = nil,
    detailRightParen: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    assert(name.text == "class" || name.text == "convenience" || name.text == "dynamic" || name.text == "final" || name.text == "infix" || name.text == "lazy" || name.text == "optional" || name.text == "override" || name.text == "postfix" || name.text == "prefix" || name.text == "required" || name.text == "static" || name.text == "unowned" || name.text == "weak" || name.text == "private" || name.text == "fileprivate" || name.text == "internal" || name.text == "public" || name.text == "open" || name.text == "mutating" || name.text == "nonmutating" || name.text == "indirect" || name.text == "__consuming" || name.text == "actor" || name.text == "async" || name.text == "distributed")
    self.detailLeftParen = detailLeftParen
    assert(detailLeftParen == nil || detailLeftParen!.text == "(")
    self.detail = detail
    self.detailRightParen = detailRightParen
    assert(detailRightParen == nil || detailRightParen!.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: String?,
    detailRightParen: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail.map(TokenSyntax.identifier),
      detailRightParen: detailRightParen
    )
  }

  /// Builds a `DeclModifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclModifierSyntax`.
  func buildDeclModifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclModifierSyntax {
    let result = SyntaxFactory.makeDeclModifier(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail,
      detailRightParen: detailRightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let typeName: TypeBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InheritedType` using the provided parameters.
  /// - Parameters:
  ///   - typeName: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    typeName: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.typeName = typeName.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `InheritedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InheritedTypeSyntax`.
  func buildInheritedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InheritedTypeSyntax {
    let result = SyntaxFactory.makeInheritedType(
      typeName: typeName.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        typeName: typeName,
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
  let colon: TokenSyntax
  let inheritedTypeCollection: InheritedTypeList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeInheritanceClause` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - inheritedTypeCollection: 
  public init(
    leadingTrivia: Trivia = [],
    colon: TokenSyntax = TokenSyntax.`colon`,
    inheritedTypeCollection: ExpressibleAsInheritedTypeList
  ) {
    self.leadingTrivia = leadingTrivia
    self.colon = colon
    assert(colon.text == ":")
    self.inheritedTypeCollection = inheritedTypeCollection.createInheritedTypeList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    colon: TokenSyntax = TokenSyntax.`colon`,
    @InheritedTypeListBuilder inheritedTypeCollectionBuilder: () -> ExpressibleAsInheritedTypeList = { InheritedTypeList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollectionBuilder()
    )
  }

  /// Builds a `TypeInheritanceClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeInheritanceClauseSyntax`.
  func buildTypeInheritanceClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeInheritanceClauseSyntax {
    let result = SyntaxFactory.makeTypeInheritanceClause(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollection.buildInheritedTypeList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let classOrActorKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClassDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - classOrActorKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    classOrActorKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.classOrActorKeyword = classOrActorKeyword
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    classOrActorKeyword: TokenSyntax,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      classOrActorKeyword: classOrActorKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: membersBuilder()
    )
  }

  /// Builds a `ClassDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClassDeclSyntax`.
  func buildClassDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClassDeclSyntax {
    let result = SyntaxFactory.makeClassDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      classOrActorKeyword: classOrActorKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct StructDecl: DeclBuildable, ExpressibleAsStructDecl {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let structKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `StructDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - structKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.structKeyword = structKeyword
    assert(structKeyword.text == "struct")
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      structKeyword: structKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: membersBuilder()
    )
  }

  /// Builds a `StructDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `StructDeclSyntax`.
  func buildStructDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> StructDeclSyntax {
    let result = SyntaxFactory.makeStructDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      structKeyword: structKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let protocolKeyword: TokenSyntax
  let identifier: TokenSyntax
  let primaryAssociatedTypeClause: PrimaryAssociatedTypeClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ProtocolDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - protocolKeyword: 
  ///   - identifier: 
  ///   - primaryAssociatedTypeClause: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: TokenSyntax,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.protocolKeyword = protocolKeyword
    assert(protocolKeyword.text == "protocol")
    self.identifier = identifier
    self.primaryAssociatedTypeClause = primaryAssociatedTypeClause?.createPrimaryAssociatedTypeClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: String,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      protocolKeyword: protocolKeyword,
      identifier: TokenSyntax.identifier(identifier),
      primaryAssociatedTypeClause: primaryAssociatedTypeClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: membersBuilder()
    )
  }

  /// Builds a `ProtocolDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ProtocolDeclSyntax`.
  func buildProtocolDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ProtocolDeclSyntax {
    let result = SyntaxFactory.makeProtocolDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      protocolKeyword: protocolKeyword,
      identifier: identifier,
      primaryAssociatedTypeClause: primaryAssociatedTypeClause?.buildPrimaryAssociatedTypeClause(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let extensionKeyword: TokenSyntax
  let extendedType: TypeBuildable
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExtensionDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - extensionKeyword: 
  ///   - extendedType: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.extensionKeyword = extensionKeyword
    assert(extensionKeyword.text == "extension")
    self.extendedType = extendedType.createTypeBuildable()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      extensionKeyword: extensionKeyword,
      extendedType: extendedType,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: membersBuilder()
    )
  }

  /// Builds a `ExtensionDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExtensionDeclSyntax`.
  func buildExtensionDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExtensionDeclSyntax {
    let result = SyntaxFactory.makeExtensionDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      extensionKeyword: extensionKeyword,
      extendedType: extendedType.buildType(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftBrace: TokenSyntax
  let members: MemberDeclList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberDeclBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - members: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    members: ExpressibleAsMemberDeclList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.members = members.createMemberDeclList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftBrace: leftBrace,
      members: membersBuilder(),
      rightBrace: rightBrace
    )
  }

  /// Builds a `MemberDeclBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberDeclBlockSyntax`.
  func buildMemberDeclBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberDeclBlockSyntax {
    let result = SyntaxFactory.makeMemberDeclBlock(
      leftBrace: leftBrace,
      members: members.buildMemberDeclList(format: format._indented(), leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let decl: DeclBuildable
  let semicolon: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberDeclListItem` using the provided parameters.
  /// - Parameters:
  ///   - decl: The declaration of the type member.
  ///   - semicolon: An optional trailing semicolon.
  public init(
    leadingTrivia: Trivia = [],
    decl: ExpressibleAsDeclBuildable,
    semicolon: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.decl = decl.createDeclBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
  }


  /// Builds a `MemberDeclListItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberDeclListItemSyntax`.
  func buildMemberDeclListItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberDeclListItemSyntax {
    let result = SyntaxFactory.makeMemberDeclListItem(
      decl: decl.buildDecl(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let statements: CodeBlockItemList
  let eofToken: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SourceFile` using the provided parameters.
  /// - Parameters:
  ///   - statements: 
  ///   - eofToken: 
  public init(
    leadingTrivia: Trivia = [],
    statements: ExpressibleAsCodeBlockItemList,
    eofToken: TokenSyntax = TokenSyntax.eof
  ) {
    self.leadingTrivia = leadingTrivia
    self.statements = statements.createCodeBlockItemList()
    self.eofToken = eofToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    eofToken: TokenSyntax = TokenSyntax.eof,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      statements: statementsBuilder(),
      eofToken: eofToken
    )
  }

  /// Builds a `SourceFileSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SourceFileSyntax`.
  func buildSourceFile(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SourceFileSyntax {
    let result = SyntaxFactory.makeSourceFile(
      statements: statements.buildCodeBlockItemList(format: format, leadingTrivia: nil),
      eofToken: eofToken
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let equal: TokenSyntax
  let value: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    leadingTrivia: Trivia = [],
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.equal = equal
    assert(equal.text == "=")
    self.value = value.createExprBuildable()
  }


  /// Builds a `InitializerClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InitializerClauseSyntax`.
  func buildInitializerClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InitializerClauseSyntax {
    let result = SyntaxFactory.makeInitializerClause(
      equal: equal,
      value: value.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let firstName: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable?
  let ellipsis: TokenSyntax?
  let defaultArgument: InitializerClause?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionParameter` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - firstName: 
  ///   - secondName: 
  ///   - colon: 
  ///   - type: 
  ///   - ellipsis: 
  ///   - defaultArgument: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.firstName = firstName
    self.secondName = secondName
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.type = type?.createTypeBuildable()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ellipsis!.text == "...")
    self.defaultArgument = defaultArgument?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `FunctionParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionParameterSyntax`.
  func buildFunctionParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionParameterSyntax {
    let result = SyntaxFactory.makeFunctionParameter(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      firstName: firstName,
      secondName: secondName,
      colon: colon,
      type: type?.buildType(format: format, leadingTrivia: nil),
      ellipsis: ellipsis,
      defaultArgument: defaultArgument?.buildInitializerClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        attributes: attributes,
        firstName: firstName,
        secondName: secondName,
        colon: colon,
        type: type,
        ellipsis: ellipsis,
        defaultArgument: defaultArgument,
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let funcKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let signature: FunctionSignature
  let genericWhereClause: GenericWhereClause?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - funcKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - signature: 
  ///   - genericWhereClause: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.funcKeyword = funcKeyword
    assert(funcKeyword.text == "func")
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.signature = signature.createFunctionSignature()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause,
      signature: signature,
      genericWhereClause: genericWhereClause,
      body: bodyBuilder()
    )
  }

  /// Builds a `FunctionDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionDeclSyntax`.
  func buildFunctionDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionDeclSyntax {
    let result = SyntaxFactory.makeFunctionDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      signature: signature.buildFunctionSignature(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let initKeyword: TokenSyntax
  let optionalMark: TokenSyntax?
  let genericParameterClause: GenericParameterClause?
  let parameters: ParameterClause
  let throwsOrRethrowsKeyword: TokenSyntax?
  let genericWhereClause: GenericWhereClause?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `InitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - initKeyword: 
  ///   - optionalMark: 
  ///   - genericParameterClause: 
  ///   - parameters: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - genericWhereClause: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    parameters: ExpressibleAsParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.initKeyword = initKeyword
    assert(initKeyword.text == "init")
    self.optionalMark = optionalMark
    assert(optionalMark == nil || optionalMark!.text == "?" || optionalMark!.text == "?" || optionalMark!.text == "!")
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.parameters = parameters.createParameterClause()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || throwsOrRethrowsKeyword!.text == "throws" || throwsOrRethrowsKeyword!.text == "rethrows")
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    parameters: ExpressibleAsParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      initKeyword: initKeyword,
      optionalMark: optionalMark,
      genericParameterClause: genericParameterClause,
      parameters: parameters,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      genericWhereClause: genericWhereClause,
      body: bodyBuilder()
    )
  }

  /// Builds a `InitializerDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `InitializerDeclSyntax`.
  func buildInitializerDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> InitializerDeclSyntax {
    let result = SyntaxFactory.makeInitializerDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      initKeyword: initKeyword,
      optionalMark: optionalMark,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      parameters: parameters.buildParameterClause(format: format, leadingTrivia: nil),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let deinitKeyword: TokenSyntax
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeinitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - deinitKeyword: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.deinitKeyword = deinitKeyword
    assert(deinitKeyword.text == "deinit")
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      deinitKeyword: deinitKeyword,
      body: bodyBuilder()
    )
  }

  /// Builds a `DeinitializerDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeinitializerDeclSyntax`.
  func buildDeinitializerDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeinitializerDeclSyntax {
    let result = SyntaxFactory.makeDeinitializerDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      deinitKeyword: deinitKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let subscriptKeyword: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let indices: ParameterClause
  let result: ReturnClause
  let genericWhereClause: GenericWhereClause?
  let accessor: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SubscriptDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - subscriptKeyword: 
  ///   - genericParameterClause: 
  ///   - indices: 
  ///   - result: 
  ///   - genericWhereClause: 
  ///   - accessor: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    indices: ExpressibleAsParameterClause,
    result: ExpressibleAsReturnClause,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.subscriptKeyword = subscriptKeyword
    assert(subscriptKeyword.text == "subscript")
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.indices = indices.createParameterClause()
    self.result = result.createReturnClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.accessor = accessor?.createSyntaxBuildable()
  }


  /// Builds a `SubscriptDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SubscriptDeclSyntax`.
  func buildSubscriptDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SubscriptDeclSyntax {
    let result = SyntaxFactory.makeSubscriptDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      subscriptKeyword: subscriptKeyword,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      indices: indices.buildParameterClause(format: format, leadingTrivia: nil),
      result: result.buildReturnClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      accessor: accessor?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let leftParen: TokenSyntax?
  let modifier: TokenSyntax?
  let rightParen: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessLevelModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - leftParen: 
  ///   - modifier: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    modifier: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.modifier = modifier
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String,
    leftParen: TokenSyntax? = nil,
    modifier: String?,
    rightParen: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: TokenSyntax.identifier(name),
      leftParen: leftParen,
      modifier: modifier.map(TokenSyntax.identifier),
      rightParen: rightParen
    )
  }

  /// Builds a `AccessLevelModifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessLevelModifierSyntax`.
  func buildAccessLevelModifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessLevelModifierSyntax {
    let result = SyntaxFactory.makeAccessLevelModifier(
      name: name,
      leftParen: leftParen,
      modifier: modifier,
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let trailingDot: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessPathComponent` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingDot: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    trailingDot: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.trailingDot = trailingDot
    assert(trailingDot == nil || trailingDot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String,
    trailingDot: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: TokenSyntax.identifier(name),
      trailingDot: trailingDot
    )
  }

  /// Builds a `AccessPathComponentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessPathComponentSyntax`.
  func buildAccessPathComponent(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessPathComponentSyntax {
    let result = SyntaxFactory.makeAccessPathComponent(
      name: name,
      trailingDot: trailingDot
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let importTok: TokenSyntax
  let importKind: TokenSyntax?
  let path: AccessPath

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImportDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - importTok: 
  ///   - importKind: 
  ///   - path: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    importTok: TokenSyntax = TokenSyntax.`import`,
    importKind: TokenSyntax? = nil,
    path: ExpressibleAsAccessPath
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.importTok = importTok
    assert(importTok.text == "import")
    self.importKind = importKind
    assert(importKind == nil || importKind!.text == "typealias" || importKind!.text == "struct" || importKind!.text == "class" || importKind!.text == "enum" || importKind!.text == "protocol" || importKind!.text == "var" || importKind!.text == "let" || importKind!.text == "func")
    self.path = path.createAccessPath()
  }


  /// Builds a `ImportDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImportDeclSyntax`.
  func buildImportDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImportDeclSyntax {
    let result = SyntaxFactory.makeImportDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      importTok: importTok,
      importKind: importKind,
      path: path.buildAccessPath(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let name: TokenSyntax
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorParameter` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: TokenSyntax,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.name = name
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: String,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftParen: leftParen,
      name: TokenSyntax.identifier(name),
      rightParen: rightParen
    )
  }

  /// Builds a `AccessorParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorParameterSyntax`.
  func buildAccessorParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorParameterSyntax {
    let result = SyntaxFactory.makeAccessorParameter(
      leftParen: leftParen,
      name: name,
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifier: DeclModifier?
  let accessorKind: TokenSyntax
  let parameter: AccessorParameter?
  let asyncKeyword: TokenSyntax?
  let throwsKeyword: TokenSyntax?
  let body: CodeBlock?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifier: 
  ///   - accessorKind: 
  ///   - parameter: 
  ///   - asyncKeyword: 
  ///   - throwsKeyword: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsKeyword: TokenSyntax? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifier = modifier?.createDeclModifier()
    self.accessorKind = accessorKind
    assert(accessorKind.text == "get" || accessorKind.text == "set" || accessorKind.text == "didSet" || accessorKind.text == "willSet" || accessorKind.text == "unsafeAddress" || accessorKind.text == "addressWithOwner" || accessorKind.text == "addressWithNativeOwner" || accessorKind.text == "unsafeMutableAddress" || accessorKind.text == "mutableAddressWithOwner" || accessorKind.text == "mutableAddressWithNativeOwner" || accessorKind.text == "_read" || accessorKind.text == "_modify")
    self.parameter = parameter?.createAccessorParameter()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.throwsKeyword = throwsKeyword
    assert(throwsKeyword == nil || throwsKeyword!.text == "throws" || throwsKeyword!.text == "rethrows")
    self.body = body?.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: TokenSyntax? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifier: modifier,
      accessorKind: accessorKind,
      parameter: parameter,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsKeyword: throwsKeyword,
      body: bodyBuilder()
    )
  }

  /// Builds a `AccessorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorDeclSyntax`.
  func buildAccessorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorDeclSyntax {
    let result = SyntaxFactory.makeAccessorDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifier: modifier?.buildDeclModifier(format: format, leadingTrivia: nil),
      accessorKind: accessorKind,
      parameter: parameter?.buildAccessorParameter(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      throwsKeyword: throwsKeyword,
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftBrace: TokenSyntax
  let accessors: AccessorList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AccessorBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - accessors: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    accessors: ExpressibleAsAccessorList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.accessors = accessors.createAccessorList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }


  /// Builds a `AccessorBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AccessorBlockSyntax`.
  func buildAccessorBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AccessorBlockSyntax {
    let result = SyntaxFactory.makeAccessorBlock(
      leftBrace: leftBrace,
      accessors: accessors.buildAccessorList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause?
  let accessor: SyntaxBuildable?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PatternBinding` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  ///   - accessor: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
    self.accessor = accessor?.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `PatternBindingSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PatternBindingSyntax`.
  func buildPatternBinding(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PatternBindingSyntax {
    let result = SyntaxFactory.makePatternBinding(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil),
      accessor: accessor?.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        pattern: pattern,
        typeAnnotation: typeAnnotation,
        initializer: initializer,
        accessor: accessor,
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let letOrVarKeyword: TokenSyntax
  let bindings: PatternBindingList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `VariableDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - letOrVarKeyword: 
  ///   - bindings: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    letOrVarKeyword: TokenSyntax,
    bindings: ExpressibleAsPatternBindingList
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.bindings = bindings.createPatternBindingList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    letOrVarKeyword: TokenSyntax,
    @PatternBindingListBuilder bindingsBuilder: () -> ExpressibleAsPatternBindingList = { PatternBindingList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindingsBuilder()
    )
  }

  /// Builds a `VariableDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `VariableDeclSyntax`.
  func buildVariableDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> VariableDeclSyntax {
    let result = SyntaxFactory.makeVariableDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindings.buildPatternBindingList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax
  let associatedValue: ParameterClause?
  let rawValue: InitializerClause?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCaseElement` using the provided parameters.
  /// - Parameters:
  ///   - identifier: The name of this case.
  ///   - associatedValue: The set of associated values of the case.
  ///   - rawValue: The raw value of this enum element, if present.
  ///   - trailingComma: The trailing comma of this element, if the case hasmultiple elements.
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax,
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
    self.associatedValue = associatedValue?.createParameterClause()
    self.rawValue = rawValue?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    identifier: String,
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      identifier: TokenSyntax.identifier(identifier),
      associatedValue: associatedValue,
      rawValue: rawValue,
      trailingComma: trailingComma
    )
  }

  /// Builds a `EnumCaseElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCaseElementSyntax`.
  func buildEnumCaseElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCaseElementSyntax {
    let result = SyntaxFactory.makeEnumCaseElement(
      identifier: identifier,
      associatedValue: associatedValue?.buildParameterClause(format: format, leadingTrivia: nil),
      rawValue: rawValue?.buildInitializerClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        identifier: identifier,
        associatedValue: associatedValue,
        rawValue: rawValue,
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let caseKeyword: TokenSyntax
  let elements: EnumCaseElementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCaseDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the case declaration.
  ///   - modifiers: The declaration modifiers applied to the case declaration.
  ///   - caseKeyword: The `case` keyword for this case.
  ///   - elements: The elements this case declares.
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    elements: ExpressibleAsEnumCaseElementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.elements = elements.createEnumCaseElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    @EnumCaseElementListBuilder elementsBuilder: () -> ExpressibleAsEnumCaseElementList = { EnumCaseElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      caseKeyword: caseKeyword,
      elements: elementsBuilder()
    )
  }

  /// Builds a `EnumCaseDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCaseDeclSyntax`.
  func buildEnumCaseDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCaseDeclSyntax {
    let result = SyntaxFactory.makeEnumCaseDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      elements: elements.buildEnumCaseElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let enumKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameters: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the enum declaration.
  ///   - modifiers: The declaration modifiers applied to the enum declaration.
  ///   - enumKeyword: The `enum` keyword for this declaration.
  ///   - identifier: The name of this enum.
  ///   - genericParameters: The generic parameters, if any, for this enum.
  ///   - inheritanceClause: The inheritance clause describing conformances or rawvalues for this enum.
  ///   - genericWhereClause: The `where` clause that applies to the generic parameters ofthis enum.
  ///   - members: The cases and other members of this enum.
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: TokenSyntax,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.enumKeyword = enumKeyword
    assert(enumKeyword.text == "enum")
    self.identifier = identifier
    self.genericParameters = genericParameters?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: String,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      enumKeyword: enumKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameters: genericParameters,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: membersBuilder()
    )
  }

  /// Builds a `EnumDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumDeclSyntax`.
  func buildEnumDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumDeclSyntax {
    let result = SyntaxFactory.makeEnumDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      enumKeyword: enumKeyword,
      identifier: identifier,
      genericParameters: genericParameters?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let operatorKeyword: TokenSyntax
  let identifier: TokenSyntax
  let operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OperatorDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the 'operator' declaration.
  ///   - modifiers: The declaration modifiers applied to the 'operator'declaration.
  ///   - operatorKeyword: 
  ///   - identifier: 
  ///   - operatorPrecedenceAndTypes: Optionally specify a precedence group and designated types.
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.operatorKeyword = operatorKeyword
    assert(operatorKeyword.text == "operator")
    self.identifier = identifier
    self.operatorPrecedenceAndTypes = operatorPrecedenceAndTypes?.createOperatorPrecedenceAndTypes()
  }


  /// Builds a `OperatorDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OperatorDeclSyntax`.
  func buildOperatorDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OperatorDeclSyntax {
    let result = SyntaxFactory.makeOperatorDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes?.buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let colon: TokenSyntax
  let precedenceGroupAndDesignatedTypes: IdentifierList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OperatorPrecedenceAndTypes` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - precedenceGroupAndDesignatedTypes: The precedence group and designated types for this operator
  public init(
    leadingTrivia: Trivia = [],
    colon: TokenSyntax = TokenSyntax.`colon`,
    precedenceGroupAndDesignatedTypes: ExpressibleAsIdentifierList
  ) {
    self.leadingTrivia = leadingTrivia
    self.colon = colon
    assert(colon.text == ":")
    self.precedenceGroupAndDesignatedTypes = precedenceGroupAndDesignatedTypes.createIdentifierList()
  }


  /// Builds a `OperatorPrecedenceAndTypesSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OperatorPrecedenceAndTypesSyntax`.
  func buildOperatorPrecedenceAndTypes(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let result = SyntaxFactory.makeOperatorPrecedenceAndTypes(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypes.buildIdentifierList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let precedencegroupKeyword: TokenSyntax
  let identifier: TokenSyntax
  let leftBrace: TokenSyntax
  let groupAttributes: PrecedenceGroupAttributeList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the 'precedencegroup' declaration.
  ///   - modifiers: The declaration modifiers applied to the 'precedencegroup'declaration.
  ///   - precedencegroupKeyword: 
  ///   - identifier: The name of this precedence group.
  ///   - leftBrace: 
  ///   - groupAttributes: The characteristics of this precedence group.
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: TokenSyntax,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.precedencegroupKeyword = precedencegroupKeyword
    assert(precedencegroupKeyword.text == "precedencegroup")
    self.identifier = identifier
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.groupAttributes = groupAttributes.createPrecedenceGroupAttributeList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: String,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      modifiers: modifiers,
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: TokenSyntax.identifier(identifier),
      leftBrace: leftBrace,
      groupAttributes: groupAttributes,
      rightBrace: rightBrace
    )
  }

  /// Builds a `PrecedenceGroupDeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupDeclSyntax`.
  func buildPrecedenceGroupDecl(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupDeclSyntax {
    let result = SyntaxFactory.makePrecedenceGroupDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: identifier,
      leftBrace: leftBrace,
      groupAttributes: groupAttributes.buildPrecedenceGroupAttributeList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let higherThanOrLowerThan: TokenSyntax
  let colon: TokenSyntax
  let otherNames: PrecedenceGroupNameList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupRelation` using the provided parameters.
  /// - Parameters:
  ///   - higherThanOrLowerThan: The relation to specified other precedence groups.
  ///   - colon: 
  ///   - otherNames: The name of other precedence group to which this precedencegroup relates.
  public init(
    leadingTrivia: Trivia = [],
    higherThanOrLowerThan: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
    self.leadingTrivia = leadingTrivia
    self.higherThanOrLowerThan = higherThanOrLowerThan
    assert(higherThanOrLowerThan.text == "higherThan" || higherThanOrLowerThan.text == "lowerThan")
    self.colon = colon
    assert(colon.text == ":")
    self.otherNames = otherNames.createPrecedenceGroupNameList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    higherThanOrLowerThan: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      higherThanOrLowerThan: TokenSyntax.identifier(higherThanOrLowerThan),
      colon: colon,
      otherNames: otherNames
    )
  }

  /// Builds a `PrecedenceGroupRelationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupRelationSyntax`.
  func buildPrecedenceGroupRelation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupRelationSyntax {
    let result = SyntaxFactory.makePrecedenceGroupRelation(
      higherThanOrLowerThan: higherThanOrLowerThan,
      colon: colon,
      otherNames: otherNames.buildPrecedenceGroupNameList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupNameElement` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: TokenSyntax.identifier(name),
      trailingComma: trailingComma
    )
  }

  /// Builds a `PrecedenceGroupNameElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupNameElementSyntax`.
  func buildPrecedenceGroupNameElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupNameElementSyntax {
    let result = SyntaxFactory.makePrecedenceGroupNameElement(
      name: name,
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let assignmentKeyword: TokenSyntax
  let colon: TokenSyntax
  let flag: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupAssignment` using the provided parameters.
  /// - Parameters:
  ///   - assignmentKeyword: 
  ///   - colon: 
  ///   - flag: When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.
  public init(
    leadingTrivia: Trivia = [],
    assignmentKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.assignmentKeyword = assignmentKeyword
    assert(assignmentKeyword.text == "assignment")
    self.colon = colon
    assert(colon.text == ":")
    self.flag = flag
    assert(flag.text == "true" || flag.text == "false")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    assignmentKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      assignmentKeyword: TokenSyntax.identifier(assignmentKeyword),
      colon: colon,
      flag: flag
    )
  }

  /// Builds a `PrecedenceGroupAssignmentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupAssignmentSyntax`.
  func buildPrecedenceGroupAssignment(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupAssignmentSyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssignment(
      assignmentKeyword: assignmentKeyword,
      colon: colon,
      flag: flag
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let associativityKeyword: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrecedenceGroupAssociativity` using the provided parameters.
  /// - Parameters:
  ///   - associativityKeyword: 
  ///   - colon: 
  ///   - value: Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all
  public init(
    leadingTrivia: Trivia = [],
    associativityKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.associativityKeyword = associativityKeyword
    assert(associativityKeyword.text == "associativity")
    self.colon = colon
    assert(colon.text == ":")
    self.value = value
    assert(value.text == "left" || value.text == "right" || value.text == "none")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    associativityKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      associativityKeyword: TokenSyntax.identifier(associativityKeyword),
      colon: colon,
      value: TokenSyntax.identifier(value)
    )
  }

  /// Builds a `PrecedenceGroupAssociativitySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrecedenceGroupAssociativitySyntax`.
  func buildPrecedenceGroupAssociativity(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrecedenceGroupAssociativitySyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssociativity(
      associativityKeyword: associativityKeyword,
      colon: colon,
      value: value
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let atSignToken: TokenSyntax
  let attributeName: TypeBuildable
  let leftParen: TokenSyntax?
  let argumentList: TupleExprElementList?
  let rightParen: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CustomAttribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.atSignToken = atSignToken
    assert(atSignToken.text == "@")
    self.attributeName = attributeName.createTypeBuildable()
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.argumentList = argumentList?.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList? = { nil }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `CustomAttributeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CustomAttributeSyntax`.
  func buildCustomAttribute(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CustomAttributeSyntax {
    let result = SyntaxFactory.makeCustomAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName.buildType(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      argumentList: argumentList?.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let atSignToken: TokenSyntax
  let attributeName: TokenSyntax
  let leftParen: TokenSyntax?
  let argument: SyntaxBuildable?
  let rightParen: TokenSyntax?
  let tokenList: TokenList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `Attribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: If the attribute takes arguments, the opening parenthesis.
  ///   - argument: The arguments of the attribute. In case the attributetakes multiple arguments, they are gather in theappropriate takes first.
  ///   - rightParen: If the attribute takes arguments, the closing parenthesis.
  ///   - tokenList: 
  public init(
    leadingTrivia: Trivia = [],
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    rightParen: TokenSyntax? = nil,
    tokenList: ExpressibleAsTokenList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.atSignToken = atSignToken
    assert(atSignToken.text == "@")
    self.attributeName = attributeName
    self.leftParen = leftParen
    assert(leftParen == nil || leftParen!.text == "(")
    self.argument = argument?.createSyntaxBuildable()
    self.rightParen = rightParen
    assert(rightParen == nil || rightParen!.text == ")")
    self.tokenList = tokenList?.createTokenList()
  }


  /// Builds a `AttributeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AttributeSyntax`.
  func buildAttribute(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AttributeSyntax {
    let result = SyntaxFactory.makeAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argument: argument?.buildSyntax(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      tokenList: tokenList?.buildTokenList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let label: TokenSyntax
  let colon: TokenSyntax
  let availabilityList: AvailabilitySpecList
  let semicolon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - availabilityList: 
  ///   - semicolon: 
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.availabilityList = availabilityList.createAvailabilitySpecList()
    self.semicolon = semicolon
    assert(semicolon.text == ";")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      label: TokenSyntax.identifier(label),
      colon: colon,
      availabilityList: availabilityList,
      semicolon: semicolon
    )
  }

  /// Builds a `AvailabilityEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityEntrySyntax`.
  func buildAvailabilityEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityEntrySyntax {
    let result = SyntaxFactory.makeAvailabilityEntry(
      label: label,
      colon: colon,
      availabilityList: availabilityList.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `LabeledSpecializeEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - value: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.value = value
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      label: TokenSyntax.identifier(label),
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
  }

  /// Builds a `LabeledSpecializeEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `LabeledSpecializeEntrySyntax`.
  func buildLabeledSpecializeEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> LabeledSpecializeEntrySyntax {
    let result = SyntaxFactory.makeLabeledSpecializeEntry(
      label: label,
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        label: label,
        colon: colon,
        value: value,
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
  let label: TokenSyntax
  let colon: TokenSyntax
  let declname: DeclName
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TargetFunctionEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - declname: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    declname: ExpressibleAsDeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.declname = declname.createDeclName()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    declname: ExpressibleAsDeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      label: TokenSyntax.identifier(label),
      colon: colon,
      declname: declname,
      trailingComma: trailingComma
    )
  }

  /// Builds a `TargetFunctionEntrySyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TargetFunctionEntrySyntax`.
  func buildTargetFunctionEntry(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TargetFunctionEntrySyntax {
    let result = SyntaxFactory.makeTargetFunctionEntry(
      label: label,
      colon: colon,
      declname: declname.buildDeclName(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        label: label,
        colon: colon,
        declname: declname,
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
  let nameTok: TokenSyntax
  let colon: TokenSyntax
  let stringOrDeclname: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `NamedAttributeStringArgument` using the provided parameters.
  /// - Parameters:
  ///   - nameTok: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - stringOrDeclname: 
  public init(
    leadingTrivia: Trivia = [],
    nameTok: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    stringOrDeclname: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.nameTok = nameTok
    self.colon = colon
    assert(colon.text == ":")
    self.stringOrDeclname = stringOrDeclname.createSyntaxBuildable()
  }


  /// Builds a `NamedAttributeStringArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `NamedAttributeStringArgumentSyntax`.
  func buildNamedAttributeStringArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> NamedAttributeStringArgumentSyntax {
    let result = SyntaxFactory.makeNamedAttributeStringArgument(
      nameTok: nameTok,
      colon: colon,
      stringOrDeclname: stringOrDeclname.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclName` using the provided parameters.
  /// - Parameters:
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    leadingTrivia: Trivia = [],
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `DeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclNameSyntax`.
  func buildDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclNameSyntax {
    let result = SyntaxFactory.makeDeclName(
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let type: SimpleTypeIdentifier
  let comma: TokenSyntax
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImplementsAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - type: The type for which the method with this attributeimplements a requirement.
  ///   - comma: The comma separating the type and method name
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    leadingTrivia: Trivia = [],
    type: ExpressibleAsSimpleTypeIdentifier,
    comma: TokenSyntax = TokenSyntax.`comma`,
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.type = type.createSimpleTypeIdentifier()
    self.comma = comma
    assert(comma.text == ",")
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  /// Builds a `ImplementsAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImplementsAttributeArgumentsSyntax`.
  func buildImplementsAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImplementsAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeImplementsAttributeArguments(
      type: type.buildSimpleTypeIdentifier(format: format, leadingTrivia: nil),
      comma: comma,
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax?
  let colon: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ObjCSelectorPiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax? = nil,
    colon: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String?,
    colon: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: name.map(TokenSyntax.identifier),
      colon: colon
    )
  }

  /// Builds a `ObjCSelectorPieceSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ObjCSelectorPieceSyntax`.
  func buildObjCSelectorPiece(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ObjCSelectorPieceSyntax {
    let result = SyntaxFactory.makeObjCSelectorPiece(
      name: name,
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let diffKind: TokenSyntax?
  let diffKindComma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?
  let diffParamsComma: TokenSyntax?
  let whereClause: GenericWhereClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiableAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - diffKind: 
  ///   - diffKindComma: The comma following the differentiability kind, if it exists.
  ///   - diffParams: 
  ///   - diffParamsComma: The comma following the differentiability parameters clause,if it exists.
  ///   - whereClause: 
  public init(
    leadingTrivia: Trivia = [],
    diffKind: TokenSyntax? = nil,
    diffKindComma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.diffKind = diffKind
    assert(diffKind == nil || diffKind!.text == "forward" || diffKind!.text == "reverse" || diffKind!.text == "linear")
    self.diffKindComma = diffKindComma
    assert(diffKindComma == nil || diffKindComma!.text == ",")
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
    self.diffParamsComma = diffParamsComma
    assert(diffParamsComma == nil || diffParamsComma!.text == ",")
    self.whereClause = whereClause?.createGenericWhereClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    diffKind: String?,
    diffKindComma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      diffKind: diffKind.map(TokenSyntax.identifier),
      diffKindComma: diffKindComma,
      diffParams: diffParams,
      diffParamsComma: diffParamsComma,
      whereClause: whereClause
    )
  }

  /// Builds a `DifferentiableAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiableAttributeArgumentsSyntax`.
  func buildDifferentiableAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiableAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDifferentiableAttributeArguments(
      diffKind: diffKind,
      diffKindComma: diffKindComma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil),
      diffParamsComma: diffParamsComma,
      whereClause: whereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let wrtLabel: TokenSyntax
  let colon: TokenSyntax
  let parameters: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParamsClause` using the provided parameters.
  /// - Parameters:
  ///   - wrtLabel: The "wrt" label.
  ///   - colon: The colon separating "wrt" and the parameter list.
  ///   - parameters: 
  public init(
    leadingTrivia: Trivia = [],
    wrtLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.wrtLabel = wrtLabel
    assert(wrtLabel.text == "wrt")
    self.colon = colon
    assert(colon.text == ":")
    self.parameters = parameters.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    wrtLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      wrtLabel: TokenSyntax.identifier(wrtLabel),
      colon: colon,
      parameters: parameters
    )
  }

  /// Builds a `DifferentiabilityParamsClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamsClauseSyntax`.
  func buildDifferentiabilityParamsClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamsClauseSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParamsClause(
      wrtLabel: wrtLabel,
      colon: colon,
      parameters: parameters.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let diffParams: DifferentiabilityParamList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParams` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - diffParams: The parameters for differentiation.
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    diffParams: ExpressibleAsDifferentiabilityParamList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.diffParams = diffParams.createDifferentiabilityParamList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `DifferentiabilityParamsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamsSyntax`.
  func buildDifferentiabilityParams(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamsSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParams(
      leftParen: leftParen,
      diffParams: diffParams.buildDifferentiabilityParamList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let parameter: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DifferentiabilityParam` using the provided parameters.
  /// - Parameters:
  ///   - parameter: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    parameter: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.parameter = parameter.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `DifferentiabilityParamSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DifferentiabilityParamSyntax`.
  func buildDifferentiabilityParam(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DifferentiabilityParamSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParam(
      parameter: parameter.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        parameter: parameter,
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
  let ofLabel: TokenSyntax
  let colon: TokenSyntax
  let originalDeclName: QualifiedDeclName
  let period: TokenSyntax?
  let accessorKind: TokenSyntax?
  let comma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DerivativeRegistrationAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - ofLabel: The "of" label.
  ///   - colon: The colon separating the "of" label and the originaldeclaration name.
  ///   - originalDeclName: The referenced original declaration name.
  ///   - period: The period separating the original declaration name and theaccessor name.
  ///   - accessorKind: The accessor name.
  ///   - comma: 
  ///   - diffParams: 
  public init(
    leadingTrivia: Trivia = [],
    ofLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: TokenSyntax? = nil,
    comma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.ofLabel = ofLabel
    assert(ofLabel.text == "of")
    self.colon = colon
    assert(colon.text == ":")
    self.originalDeclName = originalDeclName.createQualifiedDeclName()
    self.period = period
    assert(period == nil || period!.text == ".")
    self.accessorKind = accessorKind
    assert(accessorKind == nil || accessorKind!.text == "get" || accessorKind!.text == "set")
    self.comma = comma
    assert(comma == nil || comma!.text == ",")
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    ofLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: String?,
    comma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      ofLabel: TokenSyntax.identifier(ofLabel),
      colon: colon,
      originalDeclName: originalDeclName,
      period: period,
      accessorKind: accessorKind.map(TokenSyntax.identifier),
      comma: comma,
      diffParams: diffParams
    )
  }

  /// Builds a `DerivativeRegistrationAttributeArgumentsSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DerivativeRegistrationAttributeArgumentsSyntax`.
  func buildDerivativeRegistrationAttributeArguments(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDerivativeRegistrationAttributeArguments(
      ofLabel: ofLabel,
      colon: colon,
      originalDeclName: originalDeclName.buildQualifiedDeclName(format: format, leadingTrivia: nil),
      period: period,
      accessorKind: accessorKind,
      comma: comma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let baseType: TypeBuildable?
  let dot: TokenSyntax?
  let name: TokenSyntax
  let arguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `QualifiedDeclName` using the provided parameters.
  /// - Parameters:
  ///   - baseType: The base type of the qualified name, optionally specified.
  ///   - dot: 
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    leadingTrivia: Trivia = [],
    baseType: ExpressibleAsTypeBuildable? = nil,
    dot: TokenSyntax? = nil,
    name: TokenSyntax,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.baseType = baseType?.createTypeBuildable()
    self.dot = dot
    assert(dot == nil || dot!.text == "." || dot!.text == ".")
    self.name = name
    self.arguments = arguments?.createDeclNameArguments()
  }


  /// Builds a `QualifiedDeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `QualifiedDeclNameSyntax`.
  func buildQualifiedDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> QualifiedDeclNameSyntax {
    let result = SyntaxFactory.makeQualifiedDeclName(
      baseType: baseType?.buildType(format: format, leadingTrivia: nil),
      dot: dot,
      name: name,
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: SyntaxBuildable
  let arguments: DeclNameArguments?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionDeclName` using the provided parameters.
  /// - Parameters:
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    leadingTrivia: Trivia = [],
    name: ExpressibleAsSyntaxBuildable,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name.createSyntaxBuildable()
    self.arguments = arguments?.createDeclNameArguments()
  }


  /// Builds a `FunctionDeclNameSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionDeclNameSyntax`.
  func buildFunctionDeclName(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionDeclNameSyntax {
    let result = SyntaxFactory.makeFunctionDeclName(
      name: name.buildSyntax(format: format, leadingTrivia: nil),
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let beforeLabel: TokenSyntax
  let colon: TokenSyntax
  let versionList: BackDeployVersionList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BackDeployAttributeSpecList` using the provided parameters.
  /// - Parameters:
  ///   - beforeLabel: The "before" label.
  ///   - colon: The colon separating "before" and the parameter list.
  ///   - versionList: The list of OS versions in which the declaration became ABIstable.
  public init(
    leadingTrivia: Trivia = [],
    beforeLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    versionList: ExpressibleAsBackDeployVersionList
  ) {
    self.leadingTrivia = leadingTrivia
    self.beforeLabel = beforeLabel
    assert(beforeLabel.text == "before")
    self.colon = colon
    assert(colon.text == ":")
    self.versionList = versionList.createBackDeployVersionList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    beforeLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    versionList: ExpressibleAsBackDeployVersionList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      beforeLabel: TokenSyntax.identifier(beforeLabel),
      colon: colon,
      versionList: versionList
    )
  }

  /// Builds a `BackDeployAttributeSpecListSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BackDeployAttributeSpecListSyntax`.
  func buildBackDeployAttributeSpecList(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BackDeployAttributeSpecListSyntax {
    let result = SyntaxFactory.makeBackDeployAttributeSpecList(
      beforeLabel: beforeLabel,
      colon: colon,
      versionList: versionList.buildBackDeployVersionList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let availabilityVersionRestriction: AvailabilityVersionRestriction
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BackDeployVersionArgument` using the provided parameters.
  /// - Parameters:
  ///   - availabilityVersionRestriction: 
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    leadingTrivia: Trivia = [],
    availabilityVersionRestriction: ExpressibleAsAvailabilityVersionRestriction,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.availabilityVersionRestriction = availabilityVersionRestriction.createAvailabilityVersionRestriction()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `BackDeployVersionArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BackDeployVersionArgumentSyntax`.
  func buildBackDeployVersionArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BackDeployVersionArgumentSyntax {
    let result = SyntaxFactory.makeBackDeployVersionArgument(
      availabilityVersionRestriction: availabilityVersionRestriction.buildAvailabilityVersionRestriction(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct ContinueStmt: StmtBuildable, ExpressibleAsContinueStmt {
  let continueKeyword: TokenSyntax
  let label: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ContinueStmt` using the provided parameters.
  /// - Parameters:
  ///   - continueKeyword: 
  ///   - label: 
  public init(
    leadingTrivia: Trivia = [],
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.continueKeyword = continueKeyword
    assert(continueKeyword.text == "continue")
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      continueKeyword: continueKeyword,
      label: label.map(TokenSyntax.identifier)
    )
  }

  /// Builds a `ContinueStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ContinueStmtSyntax`.
  func buildContinueStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ContinueStmtSyntax {
    let result = SyntaxFactory.makeContinueStmt(
      continueKeyword: continueKeyword,
      label: label
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let whileKeyword: TokenSyntax
  let conditions: ConditionElementList
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - whileKeyword: 
  ///   - conditions: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.whileKeyword = whileKeyword
    assert(whileKeyword.text == "while")
    self.conditions = conditions.createConditionElementList()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    conditions: ExpressibleAsConditionElementList,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditions,
      body: bodyBuilder()
    )
  }

  /// Builds a `WhileStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WhileStmtSyntax`.
  func buildWhileStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WhileStmtSyntax {
    let result = SyntaxFactory.makeWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let deferKeyword: TokenSyntax
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeferStmt` using the provided parameters.
  /// - Parameters:
  ///   - deferKeyword: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.deferKeyword = deferKeyword
    assert(deferKeyword.text == "defer")
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      deferKeyword: deferKeyword,
      body: bodyBuilder()
    )
  }

  /// Builds a `DeferStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeferStmtSyntax`.
  func buildDeferStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeferStmtSyntax {
    let result = SyntaxFactory.makeDeferStmt(
      deferKeyword: deferKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionStmt` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ExpressionStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionStmtSyntax`.
  func buildExpressionStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionStmtSyntax {
    let result = SyntaxFactory.makeExpressionStmt(
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let repeatKeyword: TokenSyntax
  let body: CodeBlock
  let whileKeyword: TokenSyntax
  let condition: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `RepeatWhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - repeatKeyword: 
  ///   - body: 
  ///   - whileKeyword: 
  ///   - condition: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleAsCodeBlock,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.repeatKeyword = repeatKeyword
    assert(repeatKeyword.text == "repeat")
    self.body = body.createCodeBlock()
    self.whileKeyword = whileKeyword
    assert(whileKeyword.text == "while")
    self.condition = condition.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: bodyBuilder(),
      whileKeyword: whileKeyword,
      condition: condition
    )
  }

  /// Builds a `RepeatWhileStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `RepeatWhileStmtSyntax`.
  func buildRepeatWhileStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> RepeatWhileStmtSyntax {
    let result = SyntaxFactory.makeRepeatWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      whileKeyword: whileKeyword,
      condition: condition.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let guardKeyword: TokenSyntax
  let conditions: ConditionElementList
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GuardStmt` using the provided parameters.
  /// - Parameters:
  ///   - guardKeyword: 
  ///   - conditions: 
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    conditions: ExpressibleAsConditionElementList,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.guardKeyword = guardKeyword
    assert(guardKeyword.text == "guard")
    self.conditions = conditions.createConditionElementList()
    self.elseKeyword = elseKeyword
    assert(elseKeyword.text == "else")
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    conditions: ExpressibleAsConditionElementList,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      guardKeyword: guardKeyword,
      conditions: conditions,
      elseKeyword: elseKeyword,
      body: bodyBuilder()
    )
  }

  /// Builds a `GuardStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GuardStmtSyntax`.
  func buildGuardStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GuardStmtSyntax {
    let result = SyntaxFactory.makeGuardStmt(
      guardKeyword: guardKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let whereKeyword: TokenSyntax
  let guardResult: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - guardResult: 
  public init(
    leadingTrivia: Trivia = [],
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    guardResult: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.guardResult = guardResult.createExprBuildable()
  }


  /// Builds a `WhereClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WhereClauseSyntax`.
  func buildWhereClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WhereClauseSyntax {
    let result = SyntaxFactory.makeWhereClause(
      whereKeyword: whereKeyword,
      guardResult: guardResult.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let forKeyword: TokenSyntax
  let tryKeyword: TokenSyntax?
  let awaitKeyword: TokenSyntax?
  let caseKeyword: TokenSyntax?
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let inKeyword: TokenSyntax
  let sequenceExpr: ExprBuildable
  let whereClause: WhereClause?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ForInStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - forKeyword: 
  ///   - tryKeyword: 
  ///   - awaitKeyword: 
  ///   - caseKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - inKeyword: 
  ///   - sequenceExpr: 
  ///   - whereClause: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    tryKeyword: TokenSyntax? = nil,
    awaitKeyword: TokenSyntax? = nil,
    caseKeyword: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleAsExprBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.forKeyword = forKeyword
    assert(forKeyword.text == "for")
    self.tryKeyword = tryKeyword
    assert(tryKeyword == nil || tryKeyword!.text == "try")
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword == nil || awaitKeyword!.text == "await")
    self.caseKeyword = caseKeyword
    assert(caseKeyword == nil || caseKeyword!.text == "case")
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.inKeyword = inKeyword
    assert(inKeyword.text == "in")
    self.sequenceExpr = sequenceExpr.createExprBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    tryKeyword: TokenSyntax? = nil,
    awaitKeyword: String?,
    caseKeyword: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleAsExprBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword.map(TokenSyntax.identifier),
      caseKeyword: caseKeyword,
      pattern: pattern,
      typeAnnotation: typeAnnotation,
      inKeyword: inKeyword,
      sequenceExpr: sequenceExpr,
      whereClause: whereClause,
      body: bodyBuilder()
    )
  }

  /// Builds a `ForInStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ForInStmtSyntax`.
  func buildForInStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ForInStmtSyntax {
    let result = SyntaxFactory.makeForInStmt(
      labelName: labelName,
      labelColon: labelColon,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword,
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      inKeyword: inKeyword,
      sequenceExpr: sequenceExpr.buildExpr(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let switchKeyword: TokenSyntax
  let expression: ExprBuildable
  let leftBrace: TokenSyntax
  let cases: SwitchCaseList
  let rightBrace: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - switchKeyword: 
  ///   - expression: 
  ///   - leftBrace: 
  ///   - cases: 
  ///   - rightBrace: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    cases: ExpressibleAsSwitchCaseList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.switchKeyword = switchKeyword
    assert(switchKeyword.text == "switch")
    self.expression = expression.createExprBuildable()
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.cases = cases.createSwitchCaseList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> ExpressibleAsSwitchCaseList = { SwitchCaseList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression,
      leftBrace: leftBrace,
      cases: casesBuilder(),
      rightBrace: rightBrace
    )
  }

  /// Builds a `SwitchStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchStmtSyntax`.
  func buildSwitchStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchStmtSyntax {
    let result = SyntaxFactory.makeSwitchStmt(
      labelName: labelName,
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      cases: cases.buildSwitchCaseList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newline + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let doKeyword: TokenSyntax
  let body: CodeBlock
  let catchClauses: CatchClauseList?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DoStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - doKeyword: 
  ///   - body: 
  ///   - catchClauses: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    body: ExpressibleAsCodeBlock,
    catchClauses: ExpressibleAsCatchClauseList? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.doKeyword = doKeyword
    assert(doKeyword.text == "do")
    self.body = body.createCodeBlock()
    self.catchClauses = catchClauses?.createCatchClauseList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    catchClauses: ExpressibleAsCatchClauseList? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: bodyBuilder(),
      catchClauses: catchClauses
    )
  }

  /// Builds a `DoStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DoStmtSyntax`.
  func buildDoStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DoStmtSyntax {
    let result = SyntaxFactory.makeDoStmt(
      labelName: labelName,
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      catchClauses: catchClauses?.buildCatchClauseList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let returnKeyword: TokenSyntax
  let expression: ExprBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ReturnStmt` using the provided parameters.
  /// - Parameters:
  ///   - returnKeyword: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    returnKeyword: TokenSyntax = TokenSyntax.`return`,
    expression: ExpressibleAsExprBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.returnKeyword = returnKeyword
    assert(returnKeyword.text == "return")
    self.expression = expression?.createExprBuildable()
  }


  /// Builds a `ReturnStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ReturnStmtSyntax`.
  func buildReturnStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ReturnStmtSyntax {
    let result = SyntaxFactory.makeReturnStmt(
      returnKeyword: returnKeyword,
      expression: expression?.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let yieldKeyword: TokenSyntax
  let yields: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `YieldStmt` using the provided parameters.
  /// - Parameters:
  ///   - yieldKeyword: 
  ///   - yields: 
  public init(
    leadingTrivia: Trivia = [],
    yieldKeyword: TokenSyntax = TokenSyntax.`yield`,
    yields: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.yieldKeyword = yieldKeyword
    assert(yieldKeyword.text == "yield")
    self.yields = yields.createSyntaxBuildable()
  }


  /// Builds a `YieldStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `YieldStmtSyntax`.
  func buildYieldStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> YieldStmtSyntax {
    let result = SyntaxFactory.makeYieldStmt(
      yieldKeyword: yieldKeyword,
      yields: yields.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let elementList: ExprList
  let trailingComma: TokenSyntax?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `YieldList` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - trailingComma: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsExprList,
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elementList = elementList.createExprList()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `YieldListSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `YieldListSyntax`.
  func buildYieldList(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> YieldListSyntax {
    let result = SyntaxFactory.makeYieldList(
      leftParen: leftParen,
      elementList: elementList.buildExprList(format: format, leadingTrivia: nil),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let fallthroughKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FallthroughStmt` using the provided parameters.
  /// - Parameters:
  ///   - fallthroughKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    fallthroughKeyword: TokenSyntax = TokenSyntax.`fallthrough`
  ) {
    self.leadingTrivia = leadingTrivia
    self.fallthroughKeyword = fallthroughKeyword
    assert(fallthroughKeyword.text == "fallthrough")
  }


  /// Builds a `FallthroughStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FallthroughStmtSyntax`.
  func buildFallthroughStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FallthroughStmtSyntax {
    let result = SyntaxFactory.makeFallthroughStmt(
      fallthroughKeyword: fallthroughKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let breakKeyword: TokenSyntax
  let label: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `BreakStmt` using the provided parameters.
  /// - Parameters:
  ///   - breakKeyword: 
  ///   - label: 
  public init(
    leadingTrivia: Trivia = [],
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.breakKeyword = breakKeyword
    assert(breakKeyword.text == "break")
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      breakKeyword: breakKeyword,
      label: label.map(TokenSyntax.identifier)
    )
  }

  /// Builds a `BreakStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `BreakStmtSyntax`.
  func buildBreakStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> BreakStmtSyntax {
    let result = SyntaxFactory.makeBreakStmt(
      breakKeyword: breakKeyword,
      label: label
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let condition: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConditionElement` using the provided parameters.
  /// - Parameters:
  ///   - condition: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    condition: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.condition = condition.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `ConditionElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConditionElementSyntax`.
  func buildConditionElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConditionElementSyntax {
    let result = SyntaxFactory.makeConditionElement(
      condition: condition.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        condition: condition,
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
  let poundAvailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundAvailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundAvailableKeyword = poundAvailableKeyword
    assert(poundAvailableKeyword.text == "#available")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `AvailabilityConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityConditionSyntax`.
  func buildAvailabilityCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityConditionSyntax {
    let result = SyntaxFactory.makeAvailabilityCondition(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let caseKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MatchingPatternCondition` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    leadingTrivia: Trivia = [],
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause
  ) {
    self.leadingTrivia = leadingTrivia
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer.createInitializerClause()
  }


  /// Builds a `MatchingPatternConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MatchingPatternConditionSyntax`.
  func buildMatchingPatternCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MatchingPatternConditionSyntax {
    let result = SyntaxFactory.makeMatchingPatternCondition(
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let letOrVarKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalBindingCondition` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    leadingTrivia: Trivia = [],
    letOrVarKeyword: TokenSyntax,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
  }


  /// Builds a `OptionalBindingConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalBindingConditionSyntax`.
  func buildOptionalBindingCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalBindingConditionSyntax {
    let result = SyntaxFactory.makeOptionalBindingCondition(
      letOrVarKeyword: letOrVarKeyword,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundUnavailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `UnavailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundUnavailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundUnavailableKeyword = poundUnavailableKeyword
    assert(poundUnavailableKeyword.text == "#unavailable")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `UnavailabilityConditionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `UnavailabilityConditionSyntax`.
  func buildUnavailabilityCondition(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> UnavailabilityConditionSyntax {
    let result = SyntaxFactory.makeUnavailabilityCondition(
      poundUnavailableKeyword: poundUnavailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let declaration: DeclBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DeclarationStmt` using the provided parameters.
  /// - Parameters:
  ///   - declaration: 
  public init(
    leadingTrivia: Trivia = [],
    declaration: ExpressibleAsDeclBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.declaration = declaration.createDeclBuildable()
  }


  /// Builds a `DeclarationStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DeclarationStmtSyntax`.
  func buildDeclarationStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DeclarationStmtSyntax {
    let result = SyntaxFactory.makeDeclarationStmt(
      declaration: declaration.buildDecl(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let throwKeyword: TokenSyntax
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ThrowStmt` using the provided parameters.
  /// - Parameters:
  ///   - throwKeyword: 
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    throwKeyword: TokenSyntax = TokenSyntax.`throw`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.throwKeyword = throwKeyword
    assert(throwKeyword.text == "throw")
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ThrowStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ThrowStmtSyntax`.
  func buildThrowStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ThrowStmtSyntax {
    let result = SyntaxFactory.makeThrowStmt(
      throwKeyword: throwKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let ifKeyword: TokenSyntax
  let conditions: ConditionElementList
  let body: CodeBlock
  let elseKeyword: TokenSyntax?
  let elseBody: SyntaxBuildable?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IfStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - ifKeyword: 
  ///   - conditions: 
  ///   - body: 
  ///   - elseKeyword: 
  ///   - elseBody: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.ifKeyword = ifKeyword
    assert(ifKeyword.text == "if")
    self.conditions = conditions.createConditionElementList()
    self.body = body.createCodeBlock()
    self.elseKeyword = elseKeyword
    assert(elseKeyword == nil || elseKeyword!.text == "else")
    self.elseBody = elseBody?.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    conditions: ExpressibleAsConditionElementList,
    elseKeyword: TokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditions,
      body: bodyBuilder(),
      elseKeyword: elseKeyword,
      elseBody: elseBody
    )
  }

  /// Builds a `IfStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IfStmtSyntax`.
  func buildIfStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IfStmtSyntax {
    let result = SyntaxFactory.makeIfStmt(
      labelName: labelName,
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      elseBody: elseBody?.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let ifStatement: IfStmt

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ElseIfContinuation` using the provided parameters.
  /// - Parameters:
  ///   - ifStatement: 
  public init(
    leadingTrivia: Trivia = [],
    ifStatement: ExpressibleAsIfStmt
  ) {
    self.leadingTrivia = leadingTrivia
    self.ifStatement = ifStatement.createIfStmt()
  }


  /// Builds a `ElseIfContinuationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ElseIfContinuationSyntax`.
  func buildElseIfContinuation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ElseIfContinuationSyntax {
    let result = SyntaxFactory.makeElseIfContinuation(
      ifStatement: ifStatement.buildIfStmt(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ElseBlock` using the provided parameters.
  /// - Parameters:
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.elseKeyword = elseKeyword
    assert(elseKeyword.text == "else")
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      elseKeyword: elseKeyword,
      body: bodyBuilder()
    )
  }

  /// Builds a `ElseBlockSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ElseBlockSyntax`.
  func buildElseBlock(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ElseBlockSyntax {
    let result = SyntaxFactory.makeElseBlock(
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let unknownAttr: Attribute?
  let label: SyntaxBuildable
  let statements: CodeBlockItemList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchCase` using the provided parameters.
  /// - Parameters:
  ///   - unknownAttr: 
  ///   - label: 
  ///   - statements: 
  public init(
    leadingTrivia: Trivia = [],
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
    statements: ExpressibleAsCodeBlockItemList
  ) {
    self.leadingTrivia = leadingTrivia
    self.unknownAttr = unknownAttr?.createAttribute()
    self.label = label.createSyntaxBuildable()
    self.statements = statements.createCodeBlockItemList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unknownAttr: unknownAttr,
      label: label,
      statements: statementsBuilder()
    )
  }

  /// Builds a `SwitchCaseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchCaseSyntax`.
  func buildSwitchCase(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchCaseSyntax {
    let result = SyntaxFactory.makeSwitchCase(
      unknownAttr: unknownAttr?.buildAttribute(format: format, leadingTrivia: nil),
      label: label.buildSyntax(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let defaultKeyword: TokenSyntax
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchDefaultLabel` using the provided parameters.
  /// - Parameters:
  ///   - defaultKeyword: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    defaultKeyword: TokenSyntax = TokenSyntax.`default`,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.defaultKeyword = defaultKeyword
    assert(defaultKeyword.text == "default")
    self.colon = colon
    assert(colon.text == ":")
  }


  /// Builds a `SwitchDefaultLabelSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchDefaultLabelSyntax`.
  func buildSwitchDefaultLabel(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchDefaultLabelSyntax {
    let result = SyntaxFactory.makeSwitchDefaultLabel(
      defaultKeyword: defaultKeyword,
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let pattern: PatternBuildable
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CaseItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    pattern: ExpressibleAsPatternBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.pattern = pattern.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `CaseItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CaseItemSyntax`.
  func buildCaseItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CaseItemSyntax {
    let result = SyntaxFactory.makeCaseItem(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        pattern: pattern,
        whereClause: whereClause,
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
  let pattern: PatternBuildable?
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CatchItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    pattern: ExpressibleAsPatternBuildable? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.pattern = pattern?.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `CatchItemSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CatchItemSyntax`.
  func buildCatchItem(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CatchItemSyntax {
    let result = SyntaxFactory.makeCatchItem(
      pattern: pattern?.buildPattern(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        pattern: pattern,
        whereClause: whereClause,
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
  let caseKeyword: TokenSyntax
  let caseItems: CaseItemList
  let colon: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SwitchCaseLabel` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - caseItems: 
  ///   - colon: 
  public init(
    leadingTrivia: Trivia = [],
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    caseItems: ExpressibleAsCaseItemList,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.leadingTrivia = leadingTrivia
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.caseItems = caseItems.createCaseItemList()
    self.colon = colon
    assert(colon.text == ":")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @CaseItemListBuilder caseItemsBuilder: () -> ExpressibleAsCaseItemList = { CaseItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      caseKeyword: caseKeyword,
      caseItems: caseItemsBuilder(),
      colon: colon
    )
  }

  /// Builds a `SwitchCaseLabelSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SwitchCaseLabelSyntax`.
  func buildSwitchCaseLabel(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SwitchCaseLabelSyntax {
    let result = SyntaxFactory.makeSwitchCaseLabel(
      caseKeyword: caseKeyword,
      caseItems: caseItems.buildCaseItemList(format: format, leadingTrivia: nil),
      colon: colon
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let catchKeyword: TokenSyntax
  let catchItems: CatchItemList?
  let body: CodeBlock

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CatchClause` using the provided parameters.
  /// - Parameters:
  ///   - catchKeyword: 
  ///   - catchItems: 
  ///   - body: 
  public init(
    leadingTrivia: Trivia = [],
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    catchItems: ExpressibleAsCatchItemList? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.leadingTrivia = leadingTrivia
    self.catchKeyword = catchKeyword
    assert(catchKeyword.text == "catch")
    self.catchItems = catchItems?.createCatchItemList()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    catchItems: ExpressibleAsCatchItemList? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      catchKeyword: catchKeyword,
      catchItems: catchItems,
      body: bodyBuilder()
    )
  }

  /// Builds a `CatchClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CatchClauseSyntax`.
  func buildCatchClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CatchClauseSyntax {
    let result = SyntaxFactory.makeCatchClause(
      catchKeyword: catchKeyword,
      catchItems: catchItems?.buildCatchItemList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let poundAssert: TokenSyntax
  let leftParen: TokenSyntax
  let condition: ExprBuildable
  let comma: TokenSyntax?
  let message: TokenSyntax?
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PoundAssertStmt` using the provided parameters.
  /// - Parameters:
  ///   - poundAssert: 
  ///   - leftParen: 
  ///   - condition: The assertion condition.
  ///   - comma: The comma after the assertion condition.
  ///   - message: The assertion message.
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
    comma: TokenSyntax? = nil,
    message: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.poundAssert = poundAssert
    assert(poundAssert.text == "#assert")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.condition = condition.createExprBuildable()
    self.comma = comma
    assert(comma == nil || comma!.text == ",")
    self.message = message
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
    comma: TokenSyntax? = nil,
    message: String?,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      poundAssert: poundAssert,
      leftParen: leftParen,
      condition: condition,
      comma: comma,
      message: message.map(TokenSyntax.stringLiteral),
      rightParen: rightParen
    )
  }

  /// Builds a `PoundAssertStmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PoundAssertStmtSyntax`.
  func buildPoundAssertStmt(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PoundAssertStmtSyntax {
    let result = SyntaxFactory.makePoundAssertStmt(
      poundAssert: poundAssert,
      leftParen: leftParen,
      condition: condition.buildExpr(format: format, leadingTrivia: nil),
      comma: comma,
      message: message,
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let whereKeyword: TokenSyntax
  let requirementList: GenericRequirementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericWhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - requirementList: 
  public init(
    leadingTrivia: Trivia = [],
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    requirementList: ExpressibleAsGenericRequirementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.requirementList = requirementList.createGenericRequirementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    @GenericRequirementListBuilder requirementListBuilder: () -> ExpressibleAsGenericRequirementList = { GenericRequirementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      whereKeyword: whereKeyword,
      requirementList: requirementListBuilder()
    )
  }

  /// Builds a `GenericWhereClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericWhereClauseSyntax`.
  func buildGenericWhereClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericWhereClauseSyntax {
    let result = SyntaxFactory.makeGenericWhereClause(
      whereKeyword: whereKeyword,
      requirementList: requirementList.buildGenericRequirementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let body: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericRequirement` using the provided parameters.
  /// - Parameters:
  ///   - body: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    body: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.body = body.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `GenericRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericRequirementSyntax`.
  func buildGenericRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericRequirementSyntax {
    let result = SyntaxFactory.makeGenericRequirement(
      body: body.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        body: body,
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
  let leftTypeIdentifier: TypeBuildable
  let equalityToken: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SameTypeRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - equalityToken: 
  ///   - rightTypeIdentifier: 
  public init(
    leadingTrivia: Trivia = [],
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    equalityToken: TokenSyntax,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.equalityToken = equalityToken
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  /// Builds a `SameTypeRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SameTypeRequirementSyntax`.
  func buildSameTypeRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SameTypeRequirementSyntax {
    let result = SyntaxFactory.makeSameTypeRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      equalityToken: equalityToken,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
public struct GenericParameter: SyntaxBuildable, ExpressibleAsGenericParameter, HasTrailingComma {
  let attributes: AttributeList?
  let name: TokenSyntax
  let colon: TokenSyntax?
  let inheritedType: TypeBuildable?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericParameter` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - name: 
  ///   - colon: 
  ///   - inheritedType: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    name: TokenSyntax,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.attributes = attributes?.createAttributeList()
    self.name = name
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.inheritedType = inheritedType?.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    name: String,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes,
      name: TokenSyntax.identifier(name),
      colon: colon,
      inheritedType: inheritedType,
      trailingComma: trailingComma
    )
  }

  /// Builds a `GenericParameterSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericParameterSyntax`.
  func buildGenericParameter(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericParameterSyntax {
    let result = SyntaxFactory.makeGenericParameter(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      name: name,
      colon: colon,
      inheritedType: inheritedType?.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        attributes: attributes,
        name: name,
        colon: colon,
        inheritedType: inheritedType,
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
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrimaryAssociatedType` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    name: String,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      name: TokenSyntax.identifier(name),
      trailingComma: trailingComma
    )
  }

  /// Builds a `PrimaryAssociatedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrimaryAssociatedTypeSyntax`.
  func buildPrimaryAssociatedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedType(
      name: name,
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        name: name,
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
  let leftAngleBracket: TokenSyntax
  let genericParameterList: GenericParameterList
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - genericParameterList: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    genericParameterList: ExpressibleAsGenericParameterList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.genericParameterList = genericParameterList.createGenericParameterList()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> ExpressibleAsGenericParameterList = { GenericParameterList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterListBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }

  /// Builds a `GenericParameterClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericParameterClauseSyntax`.
  func buildGenericParameterClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericParameterClauseSyntax {
    let result = SyntaxFactory.makeGenericParameterClause(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterList.buildGenericParameterList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftTypeIdentifier: TypeBuildable
  let colon: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConformanceRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - colon: 
  ///   - rightTypeIdentifier: 
  public init(
    leadingTrivia: Trivia = [],
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  /// Builds a `ConformanceRequirementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConformanceRequirementSyntax`.
  func buildConformanceRequirement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConformanceRequirementSyntax {
    let result = SyntaxFactory.makeConformanceRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      colon: colon,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftAngleBracket: TokenSyntax
  let primaryAssociatedTypeList: PrimaryAssociatedTypeList
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `PrimaryAssociatedTypeClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - primaryAssociatedTypeList: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    primaryAssociatedTypeList: ExpressibleAsPrimaryAssociatedTypeList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.primaryAssociatedTypeList = primaryAssociatedTypeList.createPrimaryAssociatedTypeList()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }


  /// Builds a `PrimaryAssociatedTypeClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `PrimaryAssociatedTypeClauseSyntax`.
  func buildPrimaryAssociatedTypeClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeClauseSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedTypeClause(
      leftAngleBracket: leftAngleBracket,
      primaryAssociatedTypeList: primaryAssociatedTypeList.buildPrimaryAssociatedTypeList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `SimpleTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.name = name
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  /// Builds a `SimpleTypeIdentifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `SimpleTypeIdentifierSyntax`.
  func buildSimpleTypeIdentifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> SimpleTypeIdentifierSyntax {
    let result = SyntaxFactory.makeSimpleTypeIdentifier(
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let baseType: TypeBuildable
  let period: TokenSyntax
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MemberTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    leadingTrivia: Trivia = [],
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax,
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.baseType = baseType.createTypeBuildable()
    self.period = period
    assert(period.text == "." || period.text == ".")
    self.name = name
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  /// Builds a `MemberTypeIdentifierSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MemberTypeIdentifierSyntax`.
  func buildMemberTypeIdentifier(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MemberTypeIdentifierSyntax {
    let result = SyntaxFactory.makeMemberTypeIdentifier(
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      period: period,
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let classKeyword: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ClassRestrictionType` using the provided parameters.
  /// - Parameters:
  ///   - classKeyword: 
  public init(
    leadingTrivia: Trivia = [],
    classKeyword: TokenSyntax = TokenSyntax.`class`
  ) {
    self.leadingTrivia = leadingTrivia
    self.classKeyword = classKeyword
    assert(classKeyword.text == "class")
  }


  /// Builds a `ClassRestrictionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ClassRestrictionTypeSyntax`.
  func buildClassRestrictionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ClassRestrictionTypeSyntax {
    let result = SyntaxFactory.makeClassRestrictionType(
      classKeyword: classKeyword
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftSquareBracket: TokenSyntax
  let elementType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ArrayType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - elementType: 
  ///   - rightSquareBracket: 
  public init(
    leadingTrivia: Trivia = [],
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elementType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.elementType = elementType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  /// Builds a `ArrayTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ArrayTypeSyntax`.
  func buildArrayType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ArrayTypeSyntax {
    let result = SyntaxFactory.makeArrayType(
      leftSquareBracket: leftSquareBracket,
      elementType: elementType.buildType(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftSquareBracket: TokenSyntax
  let keyType: TypeBuildable
  let colon: TokenSyntax
  let valueType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `DictionaryType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - keyType: 
  ///   - colon: 
  ///   - valueType: 
  ///   - rightSquareBracket: 
  public init(
    leadingTrivia: Trivia = [],
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    keyType: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.keyType = keyType.createTypeBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.valueType = valueType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  /// Builds a `DictionaryTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `DictionaryTypeSyntax`.
  func buildDictionaryType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> DictionaryTypeSyntax {
    let result = SyntaxFactory.makeDictionaryType(
      leftSquareBracket: leftSquareBracket,
      keyType: keyType.buildType(format: format, leadingTrivia: nil),
      colon: colon,
      valueType: valueType.buildType(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let baseType: TypeBuildable
  let period: TokenSyntax
  let typeOrProtocol: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `MetatypeType` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - typeOrProtocol: 
  public init(
    leadingTrivia: Trivia = [],
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.baseType = baseType.createTypeBuildable()
    self.period = period
    assert(period.text == ".")
    self.typeOrProtocol = typeOrProtocol
    assert(typeOrProtocol.text == "Type" || typeOrProtocol.text == "Protocol")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: String
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      baseType: baseType,
      period: period,
      typeOrProtocol: TokenSyntax.identifier(typeOrProtocol)
    )
  }

  /// Builds a `MetatypeTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `MetatypeTypeSyntax`.
  func buildMetatypeType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> MetatypeTypeSyntax {
    let result = SyntaxFactory.makeMetatypeType(
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      period: period,
      typeOrProtocol: typeOrProtocol
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let wrappedType: TypeBuildable
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    wrappedType: ExpressibleAsTypeBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.wrappedType = wrappedType.createTypeBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalTypeSyntax`.
  func buildOptionalType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalTypeSyntax {
    let result = SyntaxFactory.makeOptionalType(
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let someOrAnySpecifier: TokenSyntax
  let baseType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ConstrainedSugarType` using the provided parameters.
  /// - Parameters:
  ///   - someOrAnySpecifier: 
  ///   - baseType: 
  public init(
    leadingTrivia: Trivia = [],
    someOrAnySpecifier: TokenSyntax,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.someOrAnySpecifier = someOrAnySpecifier
    assert(someOrAnySpecifier.text == "some" || someOrAnySpecifier.text == "any")
    self.baseType = baseType.createTypeBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    someOrAnySpecifier: String,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      someOrAnySpecifier: TokenSyntax.identifier(someOrAnySpecifier),
      baseType: baseType
    )
  }

  /// Builds a `ConstrainedSugarTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ConstrainedSugarTypeSyntax`.
  func buildConstrainedSugarType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ConstrainedSugarTypeSyntax {
    let result = SyntaxFactory.makeConstrainedSugarType(
      someOrAnySpecifier: someOrAnySpecifier,
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let wrappedType: TypeBuildable
  let exclamationMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ImplicitlyUnwrappedOptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - exclamationMark: 
  public init(
    leadingTrivia: Trivia = [],
    wrappedType: ExpressibleAsTypeBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.wrappedType = wrappedType.createTypeBuildable()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  /// Builds a `ImplicitlyUnwrappedOptionalTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ImplicitlyUnwrappedOptionalTypeSyntax`.
  func buildImplicitlyUnwrappedOptionalType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let result = SyntaxFactory.makeImplicitlyUnwrappedOptionalType(
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let type: TypeBuildable
  let ampersand: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CompositionTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - ampersand: 
  public init(
    leadingTrivia: Trivia = [],
    type: ExpressibleAsTypeBuildable,
    ampersand: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.type = type.createTypeBuildable()
    self.ampersand = ampersand
    assert(ampersand == nil || ampersand!.text == "&")
  }


  /// Builds a `CompositionTypeElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CompositionTypeElementSyntax`.
  func buildCompositionTypeElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CompositionTypeElementSyntax {
    let result = SyntaxFactory.makeCompositionTypeElement(
      type: type.buildType(format: format, leadingTrivia: nil),
      ampersand: ampersand
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let elements: CompositionTypeElementList

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `CompositionType` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    leadingTrivia: Trivia = [],
    elements: ExpressibleAsCompositionTypeElementList
  ) {
    self.leadingTrivia = leadingTrivia
    self.elements = elements.createCompositionTypeElementList()
  }


  /// Builds a `CompositionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `CompositionTypeSyntax`.
  func buildCompositionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> CompositionTypeSyntax {
    let result = SyntaxFactory.makeCompositionType(
      elements: elements.buildCompositionTypeElementList(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let inOut: TokenSyntax?
  let name: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable
  let ellipsis: TokenSyntax?
  let initializer: InitializerClause?
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - inOut: 
  ///   - name: 
  ///   - secondName: 
  ///   - colon: 
  ///   - type: 
  ///   - ellipsis: 
  ///   - initializer: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    inOut: TokenSyntax? = nil,
    name: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable,
    ellipsis: TokenSyntax? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.inOut = inOut
    assert(inOut == nil || inOut!.text == "inout")
    self.name = name
    self.secondName = secondName
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.type = type.createTypeBuildable()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ellipsis!.text == "...")
    self.initializer = initializer?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `TupleTypeElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleTypeElementSyntax`.
  func buildTupleTypeElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleTypeElementSyntax {
    let result = SyntaxFactory.makeTupleTypeElement(
      inOut: inOut,
      name: name,
      secondName: secondName,
      colon: colon,
      type: type.buildType(format: format, leadingTrivia: nil),
      ellipsis: ellipsis,
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        inOut: inOut,
        name: name,
        secondName: secondName,
        colon: colon,
        type: type,
        ellipsis: ellipsis,
        initializer: initializer,
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
  let leftParen: TokenSyntax
  let elements: TupleTypeElementList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TupleType` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elements = elements.createTupleTypeElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  /// Builds a `TupleTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TupleTypeSyntax`.
  func buildTupleType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TupleTypeSyntax {
    let result = SyntaxFactory.makeTupleType(
      leftParen: leftParen,
      elements: elements.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let arguments: TupleTypeElementList
  let rightParen: TokenSyntax
  let asyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `FunctionType` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  ///   - asyncKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - arrow: 
  ///   - returnType: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.arguments = arguments.createTupleTypeElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || asyncKeyword!.text == "async")
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || throwsOrRethrowsKeyword!.text == "throws" || throwsOrRethrowsKeyword!.text == "rethrows" || throwsOrRethrowsKeyword!.text == "throw")
    self.arrow = arrow
    assert(arrow.text == "->")
    self.returnType = returnType.createTypeBuildable()
  }


  /// Builds a `FunctionTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `FunctionTypeSyntax`.
  func buildFunctionType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> FunctionTypeSyntax {
    let result = SyntaxFactory.makeFunctionType(
      leftParen: leftParen,
      arguments: arguments.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      asyncKeyword: asyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      arrow: arrow,
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let specifier: TokenSyntax?
  let attributes: AttributeList?
  let baseType: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AttributedType` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - attributes: 
  ///   - baseType: 
  public init(
    leadingTrivia: Trivia = [],
    specifier: TokenSyntax? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.specifier = specifier
    assert(specifier == nil || specifier!.text == "inout" || specifier!.text == "__shared" || specifier!.text == "__owned")
    self.attributes = attributes?.createAttributeList()
    self.baseType = baseType.createTypeBuildable()
  }


  /// Builds a `AttributedTypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AttributedTypeSyntax`.
  func buildAttributedType(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AttributedTypeSyntax {
    let result = SyntaxFactory.makeAttributedType(
      specifier: specifier,
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let argumentType: TypeBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericArgument` using the provided parameters.
  /// - Parameters:
  ///   - argumentType: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    argumentType: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.argumentType = argumentType.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `GenericArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericArgumentSyntax`.
  func buildGenericArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericArgumentSyntax {
    let result = SyntaxFactory.makeGenericArgument(
      argumentType: argumentType.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        argumentType: argumentType,
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
  let leftAngleBracket: TokenSyntax
  let arguments: GenericArgumentList
  let rightAngleBracket: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `GenericArgumentClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - arguments: 
  ///   - rightAngleBracket: 
  public init(
    leadingTrivia: Trivia = [],
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    arguments: ExpressibleAsGenericArgumentList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.arguments = arguments.createGenericArgumentList()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> ExpressibleAsGenericArgumentList = { GenericArgumentList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftAngleBracket: leftAngleBracket,
      arguments: argumentsBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }

  /// Builds a `GenericArgumentClauseSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `GenericArgumentClauseSyntax`.
  func buildGenericArgumentClause(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> GenericArgumentClauseSyntax {
    let result = SyntaxFactory.makeGenericArgumentClause(
      leftAngleBracket: leftAngleBracket,
      arguments: arguments.buildGenericArgumentList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let colon: TokenSyntax
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TypeAnnotation` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    colon: TokenSyntax = TokenSyntax.`colon`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.colon = colon
    assert(colon.text == ":")
    self.type = type.createTypeBuildable()
  }


  /// Builds a `TypeAnnotationSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TypeAnnotationSyntax`.
  func buildTypeAnnotation(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TypeAnnotationSyntax {
    let result = SyntaxFactory.makeTypeAnnotation(
      colon: colon,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let type: TypeBuildable?
  let period: TokenSyntax
  let caseName: TokenSyntax
  let associatedTuple: TuplePattern?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `EnumCasePattern` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - period: 
  ///   - caseName: 
  ///   - associatedTuple: 
  public init(
    leadingTrivia: Trivia = [],
    type: ExpressibleAsTypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: TokenSyntax,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.type = type?.createTypeBuildable()
    self.period = period
    assert(period.text == ".")
    self.caseName = caseName
    self.associatedTuple = associatedTuple?.createTuplePattern()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    type: ExpressibleAsTypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: String,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      type: type,
      period: period,
      caseName: TokenSyntax.identifier(caseName),
      associatedTuple: associatedTuple
    )
  }

  /// Builds a `EnumCasePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `EnumCasePatternSyntax`.
  func buildEnumCasePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> EnumCasePatternSyntax {
    let result = SyntaxFactory.makeEnumCasePattern(
      type: type?.buildType(format: format, leadingTrivia: nil),
      period: period,
      caseName: caseName,
      associatedTuple: associatedTuple?.buildTuplePattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let isKeyword: TokenSyntax
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - isKeyword: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    isKeyword: TokenSyntax = TokenSyntax.`is`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.isKeyword = isKeyword
    assert(isKeyword.text == "is")
    self.type = type.createTypeBuildable()
  }


  /// Builds a `IsTypePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IsTypePatternSyntax`.
  func buildIsTypePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IsTypePatternSyntax {
    let result = SyntaxFactory.makeIsTypePattern(
      isKeyword: isKeyword,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let subPattern: PatternBuildable
  let questionMark: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `OptionalPattern` using the provided parameters.
  /// - Parameters:
  ///   - subPattern: 
  ///   - questionMark: 
  public init(
    leadingTrivia: Trivia = [],
    subPattern: ExpressibleAsPatternBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.leadingTrivia = leadingTrivia
    self.subPattern = subPattern.createPatternBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  /// Builds a `OptionalPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `OptionalPatternSyntax`.
  func buildOptionalPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> OptionalPatternSyntax {
    let result = SyntaxFactory.makeOptionalPattern(
      subPattern: subPattern.buildPattern(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let identifier: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `IdentifierPattern` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  public init(
    leadingTrivia: Trivia = [],
    identifier: TokenSyntax
  ) {
    self.leadingTrivia = leadingTrivia
    self.identifier = identifier
  }


  /// Builds a `IdentifierPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `IdentifierPatternSyntax`.
  func buildIdentifierPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> IdentifierPatternSyntax {
    let result = SyntaxFactory.makeIdentifierPattern(
      identifier: identifier
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let pattern: PatternBuildable
  let asKeyword: TokenSyntax
  let type: TypeBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - asKeyword: 
  ///   - type: 
  public init(
    leadingTrivia: Trivia = [],
    pattern: ExpressibleAsPatternBuildable,
    asKeyword: TokenSyntax = TokenSyntax.`as`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.pattern = pattern.createPatternBuildable()
    self.asKeyword = asKeyword
    assert(asKeyword.text == "as")
    self.type = type.createTypeBuildable()
  }


  /// Builds a `AsTypePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AsTypePatternSyntax`.
  func buildAsTypePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AsTypePatternSyntax {
    let result = SyntaxFactory.makeAsTypePattern(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      asKeyword: asKeyword,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let leftParen: TokenSyntax
  let elements: TuplePatternElementList
  let rightParen: TokenSyntax

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TuplePattern` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTuplePatternElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leadingTrivia = leadingTrivia
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elements = elements.createTuplePatternElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> ExpressibleAsTuplePatternElementList = { TuplePatternElementList([]) }
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }

  /// Builds a `TuplePatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TuplePatternSyntax`.
  func buildTuplePattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TuplePatternSyntax {
    let result = SyntaxFactory.makeTuplePattern(
      leftParen: leftParen,
      elements: elements.buildTuplePatternElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let wildcard: TokenSyntax
  let typeAnnotation: TypeAnnotation?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `WildcardPattern` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  ///   - typeAnnotation: 
  public init(
    leadingTrivia: Trivia = [],
    wildcard: TokenSyntax = TokenSyntax.`wildcard`,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.wildcard = wildcard
    assert(wildcard.text == "_")
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
  }


  /// Builds a `WildcardPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `WildcardPatternSyntax`.
  func buildWildcardPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> WildcardPatternSyntax {
    let result = SyntaxFactory.makeWildcardPattern(
      wildcard: wildcard,
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let pattern: PatternBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `TuplePatternElement` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - pattern: 
  ///   - trailingComma: 
  public init(
    leadingTrivia: Trivia = [],
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || labelColon!.text == ":")
    self.pattern = pattern.createPatternBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      pattern: pattern,
      trailingComma: trailingComma
    )
  }

  /// Builds a `TuplePatternElementSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `TuplePatternElementSyntax`.
  func buildTuplePatternElement(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> TuplePatternElementSyntax {
    let result = SyntaxFactory.makeTuplePatternElement(
      labelName: labelName,
      labelColon: labelColon,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
        labelName: labelName,
        labelColon: labelColon,
        pattern: pattern,
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
  let expression: ExprBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ExpressionPattern` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    leadingTrivia: Trivia = [],
    expression: ExpressibleAsExprBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.expression = expression.createExprBuildable()
  }


  /// Builds a `ExpressionPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ExpressionPatternSyntax`.
  func buildExpressionPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ExpressionPatternSyntax {
    let result = SyntaxFactory.makeExpressionPattern(
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let letOrVarKeyword: TokenSyntax
  let valuePattern: PatternBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `ValueBindingPattern` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - valuePattern: 
  public init(
    leadingTrivia: Trivia = [],
    letOrVarKeyword: TokenSyntax,
    valuePattern: ExpressibleAsPatternBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.valuePattern = valuePattern.createPatternBuildable()
  }


  /// Builds a `ValueBindingPatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `ValueBindingPatternSyntax`.
  func buildValueBindingPattern(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> ValueBindingPatternSyntax {
    let result = SyntaxFactory.makeValueBindingPattern(
      letOrVarKeyword: letOrVarKeyword,
      valuePattern: valuePattern.buildPattern(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let entry: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityArgument` using the provided parameters.
  /// - Parameters:
  ///   - entry: The actual argument
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    leadingTrivia: Trivia = [],
    entry: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.entry = entry.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  /// Builds a `AvailabilityArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityArgumentSyntax`.
  func buildAvailabilityArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityArgument(
      entry: entry.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: SyntaxBuildable

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityLabeledArgument` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating label and value
  ///   - value: The value of this labeled argument
  public init(
    leadingTrivia: Trivia = [],
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.leadingTrivia = leadingTrivia
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.value = value.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      label: TokenSyntax.identifier(label),
      colon: colon,
      value: value
    )
  }

  /// Builds a `AvailabilityLabeledArgumentSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityLabeledArgumentSyntax`.
  func buildAvailabilityLabeledArgument(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityLabeledArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityLabeledArgument(
      label: label,
      colon: colon,
      value: value.buildSyntax(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let platform: TokenSyntax
  let version: VersionTuple?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `AvailabilityVersionRestriction` using the provided parameters.
  /// - Parameters:
  ///   - platform: The name of the OS on which the availability should berestricted or 'swift' if the availability should berestricted based on a Swift version.
  ///   - version: 
  public init(
    leadingTrivia: Trivia = [],
    platform: TokenSyntax,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.platform = platform
    self.version = version?.createVersionTuple()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    platform: String,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      platform: TokenSyntax.identifier(platform),
      version: version
    )
  }

  /// Builds a `AvailabilityVersionRestrictionSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `AvailabilityVersionRestrictionSyntax`.
  func buildAvailabilityVersionRestriction(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> AvailabilityVersionRestrictionSyntax {
    let result = SyntaxFactory.makeAvailabilityVersionRestriction(
      platform: platform,
      version: version?.buildVersionTuple(format: format, leadingTrivia: nil)
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
  let majorMinor: SyntaxBuildable
  let patchPeriod: TokenSyntax?
  let patchVersion: TokenSyntax?

  /// The leading trivia attached to this syntax node once built.
  /// This is typically used to add comments (e.g. for documentation).
  let leadingTrivia: Trivia

  /// Creates a `VersionTuple` using the provided parameters.
  /// - Parameters:
  ///   - majorMinor: In case the version consists only of the major version, aninteger literal that specifies the major version. In casethe version consists of major and minor version number, afloating literal in which the decimal part is interpretedas the minor version.
  ///   - patchPeriod: If the version contains a patch number, the periodseparating the minor from the patch number.
  ///   - patchVersion: The patch version if specified.
  public init(
    leadingTrivia: Trivia = [],
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: TokenSyntax? = nil
  ) {
    self.leadingTrivia = leadingTrivia
    self.majorMinor = majorMinor.createSyntaxBuildable()
    self.patchPeriod = patchPeriod
    assert(patchPeriod == nil || patchPeriod!.text == ".")
    self.patchVersion = patchVersion
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leadingTrivia: Trivia = [],
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: String?
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }

  /// Builds a `VersionTupleSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.
  /// - Returns: The built `VersionTupleSyntax`.
  func buildVersionTuple(format: Format, leadingTrivia additionalLeadingTrivia: Trivia? = nil) -> VersionTupleSyntax {
    let result = SyntaxFactory.makeVersionTuple(
      majorMinor: majorMinor.buildSyntax(format: format, leadingTrivia: nil),
      patchPeriod: patchPeriod,
      patchVersion: patchVersion
    )
    let combinedLeadingTrivia = leadingTrivia + (additionalLeadingTrivia ?? []) + (result.leadingTrivia ?? [])
    return result.withLeadingTrivia(combinedLeadingTrivia)
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
