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

  /// Creates a `CodeBlockItem` using the provided parameters.
  /// - Parameters:
  ///   - item: The underlying node inside the code block.
  ///   - semicolon: If present, the trailing semicolon at the end of the item.
  ///   - errorTokens: 
  public init(
    item: ExpressibleAsSyntaxBuildable,
    semicolon: TokenSyntax? = nil,
    errorTokens: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.item = item.createSyntaxBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
    self.errorTokens = errorTokens?.createSyntaxBuildable()
  }


  func buildCodeBlockItem(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockItemSyntax {
    let result = SyntaxFactory.makeCodeBlockItem(
      item: item.buildSyntax(format: format, leadingTrivia: nil),
      semicolon: semicolon,
      errorTokens: errorTokens?.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCodeBlockItem(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `CodeBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leftBrace: leftBrace,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildCodeBlock(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockSyntax {
    let result = SyntaxFactory.makeCodeBlock(
      leftBrace: leftBrace,
      statements: statements.buildCodeBlockItemList(format: format._indented(), leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCodeBlock(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `InOutExpr` using the provided parameters.
  /// - Parameters:
  ///   - ampersand: 
  ///   - expression: 
  public init(
    ampersand: TokenSyntax = TokenSyntax.`prefixAmpersand`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.ampersand = ampersand
    assert(ampersand.text == "&")
    self.expression = expression.createExprBuildable()
  }


  func buildInOutExpr(format: Format, leadingTrivia: Trivia? = nil) -> InOutExprSyntax {
    let result = SyntaxFactory.makeInOutExpr(
      ampersand: ampersand,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildInOutExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundColumnExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundColumn: 
  public init(
    poundColumn: TokenSyntax = TokenSyntax.`poundColumn`
  ) {
    self.poundColumn = poundColumn
    assert(poundColumn.text == "#column")
  }


  func buildPoundColumnExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundColumnExprSyntax {
    let result = SyntaxFactory.makePoundColumnExpr(
      poundColumn: poundColumn
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundColumnExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TryExpr` using the provided parameters.
  /// - Parameters:
  ///   - tryKeyword: 
  ///   - questionOrExclamationMark: 
  ///   - expression: 
  public init(
    tryKeyword: TokenSyntax = TokenSyntax.`try`,
    questionOrExclamationMark: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.tryKeyword = tryKeyword
    assert(tryKeyword.text == "try")
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.expression = expression.createExprBuildable()
  }


  func buildTryExpr(format: Format, leadingTrivia: Trivia? = nil) -> TryExprSyntax {
    let result = SyntaxFactory.makeTryExpr(
      tryKeyword: tryKeyword,
      questionOrExclamationMark: questionOrExclamationMark,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTryExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AwaitExpr` using the provided parameters.
  /// - Parameters:
  ///   - awaitKeyword: 
  ///   - expression: 
  public init(
    awaitKeyword: TokenSyntax,
    expression: ExpressibleAsExprBuildable
  ) {
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword.text == "await")
    self.expression = expression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    awaitKeyword: String,
    expression: ExpressibleAsExprBuildable
  ) {
    self.init(
      awaitKeyword: TokenSyntax.identifier(awaitKeyword),
      expression: expression
    )
  }

  func buildAwaitExpr(format: Format, leadingTrivia: Trivia? = nil) -> AwaitExprSyntax {
    let result = SyntaxFactory.makeAwaitExpr(
      awaitKeyword: awaitKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAwaitExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeclNameArgument` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    name: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.name = name
    self.colon = colon
    assert(colon.text == ":")
  }


  func buildDeclNameArgument(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentSyntax {
    let result = SyntaxFactory.makeDeclNameArgument(
      name: name,
      colon: colon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclNameArgument(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeclNameArguments` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsDeclNameArgumentList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.arguments = arguments.createDeclNameArgumentList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @DeclNameArgumentListBuilder argumentsBuilder: () -> ExpressibleAsDeclNameArgumentList = { DeclNameArgumentList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen
    )
  }

  func buildDeclNameArguments(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentsSyntax {
    let result = SyntaxFactory.makeDeclNameArguments(
      leftParen: leftParen,
      arguments: arguments.buildDeclNameArgumentList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclNameArguments(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IdentifierExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - declNameArguments: 
  public init(
    identifier: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.identifier = identifier
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  func buildIdentifierExpr(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierExprSyntax {
    let result = SyntaxFactory.makeIdentifierExpr(
      identifier: identifier,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIdentifierExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SuperRefExpr` using the provided parameters.
  /// - Parameters:
  ///   - superKeyword: 
  public init(
    superKeyword: TokenSyntax = TokenSyntax.`super`
  ) {
    self.superKeyword = superKeyword
    assert(superKeyword.text == "super")
  }


  func buildSuperRefExpr(format: Format, leadingTrivia: Trivia? = nil) -> SuperRefExprSyntax {
    let result = SyntaxFactory.makeSuperRefExpr(
      superKeyword: superKeyword
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSuperRefExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `NilLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - nilKeyword: 
  public init(
    nilKeyword: TokenSyntax = TokenSyntax.`nil`
  ) {
    self.nilKeyword = nilKeyword
    assert(nilKeyword.text == "nil")
  }


  func buildNilLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> NilLiteralExprSyntax {
    let result = SyntaxFactory.makeNilLiteralExpr(
      nilKeyword: nilKeyword
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildNilLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DiscardAssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  public init(
    wildcard: TokenSyntax = TokenSyntax.`wildcard`
  ) {
    self.wildcard = wildcard
    assert(wildcard.text == "_")
  }


  func buildDiscardAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> DiscardAssignmentExprSyntax {
    let result = SyntaxFactory.makeDiscardAssignmentExpr(
      wildcard: wildcard
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildDiscardAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - assignToken: 
  public init(
    assignToken: TokenSyntax = TokenSyntax.`equal`
  ) {
    self.assignToken = assignToken
    assert(assignToken.text == "=")
  }


  func buildAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> AssignmentExprSyntax {
    let result = SyntaxFactory.makeAssignmentExpr(
      assignToken: assignToken
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SequenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    elements: ExpressibleAsExprList
  ) {
    self.elements = elements.createExprList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    @ExprListBuilder elementsBuilder: () -> ExpressibleAsExprList = { ExprList([]) }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }

  func buildSequenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SequenceExprSyntax {
    let result = SyntaxFactory.makeSequenceExpr(
      elements: elements.buildExprList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSequenceExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundLineExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundLine: 
  public init(
    poundLine: TokenSyntax = TokenSyntax.`poundLine`
  ) {
    self.poundLine = poundLine
    assert(poundLine.text == "#line")
  }


  func buildPoundLineExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundLineExprSyntax {
    let result = SyntaxFactory.makePoundLineExpr(
      poundLine: poundLine
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundLineExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundFileExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFile: 
  public init(
    poundFile: TokenSyntax = TokenSyntax.`poundFile`
  ) {
    self.poundFile = poundFile
    assert(poundFile.text == "#file")
  }


  func buildPoundFileExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileExprSyntax {
    let result = SyntaxFactory.makePoundFileExpr(
      poundFile: poundFile
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFileExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundFileIDExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFileID: 
  public init(
    poundFileID: TokenSyntax = TokenSyntax.`poundFileID`
  ) {
    self.poundFileID = poundFileID
    assert(poundFileID.text == "#fileID")
  }


  func buildPoundFileIDExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileIDExprSyntax {
    let result = SyntaxFactory.makePoundFileIDExpr(
      poundFileID: poundFileID
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFileIDExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundFilePathExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFilePath: 
  public init(
    poundFilePath: TokenSyntax = TokenSyntax.`poundFilePath`
  ) {
    self.poundFilePath = poundFilePath
    assert(poundFilePath.text == "#filePath")
  }


  func buildPoundFilePathExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFilePathExprSyntax {
    let result = SyntaxFactory.makePoundFilePathExpr(
      poundFilePath: poundFilePath
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFilePathExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundFunctionExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFunction: 
  public init(
    poundFunction: TokenSyntax = TokenSyntax.`poundFunction`
  ) {
    self.poundFunction = poundFunction
    assert(poundFunction.text == "#function")
  }


  func buildPoundFunctionExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFunctionExprSyntax {
    let result = SyntaxFactory.makePoundFunctionExpr(
      poundFunction: poundFunction
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundFunctionExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundDsohandleExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundDsohandle: 
  public init(
    poundDsohandle: TokenSyntax = TokenSyntax.`poundDsohandle`
  ) {
    self.poundDsohandle = poundDsohandle
    assert(poundDsohandle.text == "#dsohandle")
  }


  func buildPoundDsohandleExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundDsohandleExprSyntax {
    let result = SyntaxFactory.makePoundDsohandleExpr(
      poundDsohandle: poundDsohandle
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPoundDsohandleExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SymbolicReferenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - genericArgumentClause: 
  public init(
    identifier: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.identifier = identifier
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    identifier: String,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.init(
      identifier: TokenSyntax.identifier(identifier),
      genericArgumentClause: genericArgumentClause
    )
  }

  func buildSymbolicReferenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SymbolicReferenceExprSyntax {
    let result = SyntaxFactory.makeSymbolicReferenceExpr(
      identifier: identifier,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSymbolicReferenceExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrefixOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
  ///   - postfixExpression: 
  public init(
    operatorToken: TokenSyntax? = nil,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.operatorToken = operatorToken
    self.postfixExpression = postfixExpression.createExprBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    operatorToken: String?,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.init(
      operatorToken: operatorToken.map(TokenSyntax.prefixOperator),
      postfixExpression: postfixExpression
    )
  }

  func buildPrefixOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> PrefixOperatorExprSyntax {
    let result = SyntaxFactory.makePrefixOperatorExpr(
      operatorToken: operatorToken,
      postfixExpression: postfixExpression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPrefixOperatorExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `BinaryOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
  public init(
    operatorToken: TokenSyntax
  ) {
    self.operatorToken = operatorToken
  }


  func buildBinaryOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> BinaryOperatorExprSyntax {
    let result = SyntaxFactory.makeBinaryOperatorExpr(
      operatorToken: operatorToken
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildBinaryOperatorExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ArrowExpr` using the provided parameters.
  /// - Parameters:
  ///   - asyncKeyword: 
  ///   - throwsToken: 
  ///   - arrowToken: 
  public init(
    asyncKeyword: TokenSyntax? = nil,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
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
    asyncKeyword: String?,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.init(
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
  }

  func buildArrowExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrowExprSyntax {
    let result = SyntaxFactory.makeArrowExpr(
      asyncKeyword: asyncKeyword,
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildArrowExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `FloatLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - floatingDigits: 
  public init(
    floatingDigits: TokenSyntax
  ) {
    self.floatingDigits = floatingDigits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    floatingDigits: String
  ) {
    self.init(
      floatingDigits: TokenSyntax.floatingLiteral(floatingDigits)
    )
  }

  func buildFloatLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> FloatLiteralExprSyntax {
    let result = SyntaxFactory.makeFloatLiteralExpr(
      floatingDigits: floatingDigits
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildFloatLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TupleExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      elementList: elementListBuilder(),
      rightParen: rightParen
    )
  }

  func buildTupleExpr(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprSyntax {
    let result = SyntaxFactory.makeTupleExpr(
      leftParen: leftParen,
      elementList: elementList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTupleExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ArrayExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - elements: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elements: ExpressibleAsArrayElementList,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
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
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ExpressibleAsArrayElementList = { ArrayElementList([]) }
  ) {
    self.init(
      leftSquare: leftSquare,
      elements: elementsBuilder(),
      rightSquare: rightSquare
    )
  }

  func buildArrayExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrayExprSyntax {
    let result = SyntaxFactory.makeArrayExpr(
      leftSquare: leftSquare,
      elements: elements.buildArrayElementList(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildArrayExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DictionaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - content: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    content: ExpressibleAsSyntaxBuildable,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare
    assert(leftSquare.text == "[")
    self.content = content.createSyntaxBuildable()
    self.rightSquare = rightSquare
    assert(rightSquare.text == "]")
  }


  func buildDictionaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryExprSyntax {
    let result = SyntaxFactory.makeDictionaryExpr(
      leftSquare: leftSquare,
      content: content.buildSyntax(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildDictionaryExpr(format: format, leadingTrivia: leadingTrivia)
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
public struct TupleExprElement: SyntaxBuildable, ExpressibleAsTupleExprElement {
  let label: TokenSyntax?
  let colon: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `TupleExprElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    label: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.label = label
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildTupleExprElement(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprElementSyntax {
    let result = SyntaxFactory.makeTupleExprElement(
      label: label,
      colon: colon,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTupleExprElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTupleExprElement`.
  public func createTupleExprElement() -> TupleExprElement {
    return self
  }

  /// `TupleExprElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct ArrayElement: SyntaxBuildable, ExpressibleAsArrayElement {
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `ArrayElement` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildArrayElement(format: Format, leadingTrivia: Trivia? = nil) -> ArrayElementSyntax {
    let result = SyntaxFactory.makeArrayElement(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildArrayElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsArrayElement`.
  public func createArrayElement() -> ArrayElement {
    return self
  }

  /// `ArrayElement` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct DictionaryElement: SyntaxBuildable, ExpressibleAsDictionaryElement {
  let keyExpression: ExprBuildable
  let colon: TokenSyntax
  let valueExpression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `DictionaryElement` using the provided parameters.
  /// - Parameters:
  ///   - keyExpression: 
  ///   - colon: 
  ///   - valueExpression: 
  ///   - trailingComma: 
  public init(
    keyExpression: ExpressibleAsExprBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueExpression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.keyExpression = keyExpression.createExprBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.valueExpression = valueExpression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildDictionaryElement(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryElementSyntax {
    let result = SyntaxFactory.makeDictionaryElement(
      keyExpression: keyExpression.buildExpr(format: format, leadingTrivia: nil),
      colon: colon,
      valueExpression: valueExpression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDictionaryElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDictionaryElement`.
  public func createDictionaryElement() -> DictionaryElement {
    return self
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

  /// Creates a `IntegerLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - digits: 
  public init(
    digits: TokenSyntax
  ) {
    self.digits = digits
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    digits: String
  ) {
    self.init(
      digits: TokenSyntax.integerLiteral(digits)
    )
  }

  func buildIntegerLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> IntegerLiteralExprSyntax {
    let result = SyntaxFactory.makeIntegerLiteralExpr(
      digits: digits
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIntegerLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `BooleanLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - booleanLiteral: 
  public init(
    booleanLiteral: TokenSyntax
  ) {
    self.booleanLiteral = booleanLiteral
    assert(booleanLiteral.text == "true" || booleanLiteral.text == "false")
  }


  func buildBooleanLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> BooleanLiteralExprSyntax {
    let result = SyntaxFactory.makeBooleanLiteralExpr(
      booleanLiteral: booleanLiteral
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildBooleanLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TernaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - conditionExpression: 
  ///   - questionMark: 
  ///   - firstChoice: 
  ///   - colonMark: 
  ///   - secondChoice: 
  public init(
    conditionExpression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`infixQuestionMark`,
    firstChoice: ExpressibleAsExprBuildable,
    colonMark: TokenSyntax = TokenSyntax.`colon`,
    secondChoice: ExpressibleAsExprBuildable
  ) {
    self.conditionExpression = conditionExpression.createExprBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
    self.firstChoice = firstChoice.createExprBuildable()
    self.colonMark = colonMark
    assert(colonMark.text == ":")
    self.secondChoice = secondChoice.createExprBuildable()
  }


  func buildTernaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> TernaryExprSyntax {
    let result = SyntaxFactory.makeTernaryExpr(
      conditionExpression: conditionExpression.buildExpr(format: format, leadingTrivia: nil),
      questionMark: questionMark,
      firstChoice: firstChoice.buildExpr(format: format, leadingTrivia: nil),
      colonMark: colonMark,
      secondChoice: secondChoice.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTernaryExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MemberAccessExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - dot: 
  ///   - name: 
  ///   - declNameArguments: 
  public init(
    base: ExpressibleAsExprBuildable? = nil,
    dot: TokenSyntax,
    name: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.base = base?.createExprBuildable()
    self.dot = dot
    assert(dot.text == "." || dot.text == ".")
    self.name = name
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  func buildMemberAccessExpr(format: Format, leadingTrivia: Trivia? = nil) -> MemberAccessExprSyntax {
    let result = SyntaxFactory.makeMemberAccessExpr(
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      dot: dot,
      name: name,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildMemberAccessExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IsExpr` using the provided parameters.
  /// - Parameters:
  ///   - isTok: 
  ///   - typeName: 
  public init(
    isTok: TokenSyntax = TokenSyntax.`is`,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.isTok = isTok
    assert(isTok.text == "is")
    self.typeName = typeName.createTypeBuildable()
  }


  func buildIsExpr(format: Format, leadingTrivia: Trivia? = nil) -> IsExprSyntax {
    let result = SyntaxFactory.makeIsExpr(
      isTok: isTok,
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildIsExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AsExpr` using the provided parameters.
  /// - Parameters:
  ///   - asTok: 
  ///   - questionOrExclamationMark: 
  ///   - typeName: 
  public init(
    asTok: TokenSyntax = TokenSyntax.`as`,
    questionOrExclamationMark: TokenSyntax? = nil,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.asTok = asTok
    assert(asTok.text == "as")
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || questionOrExclamationMark!.text == "?" || questionOrExclamationMark!.text == "!")
    self.typeName = typeName.createTypeBuildable()
  }


  func buildAsExpr(format: Format, leadingTrivia: Trivia? = nil) -> AsExprSyntax {
    let result = SyntaxFactory.makeAsExpr(
      asTok: asTok,
      questionOrExclamationMark: questionOrExclamationMark,
      typeName: typeName.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildAsExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TypeExpr` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  public init(
    type: ExpressibleAsTypeBuildable
  ) {
    self.type = type.createTypeBuildable()
  }


  func buildTypeExpr(format: Format, leadingTrivia: Trivia? = nil) -> TypeExprSyntax {
    let result = SyntaxFactory.makeTypeExpr(
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildTypeExpr(format: format, leadingTrivia: leadingTrivia)
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
public struct ClosureCaptureItem: SyntaxBuildable, ExpressibleAsClosureCaptureItem {
  let specifier: TokenList?
  let name: TokenSyntax?
  let assignToken: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `ClosureCaptureItem` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - name: 
  ///   - assignToken: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    specifier: ExpressibleAsTokenList? = nil,
    name: TokenSyntax? = nil,
    assignToken: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
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
    name: String?,
    assignToken: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil,
    @TokenListBuilder specifierBuilder: () -> ExpressibleAsTokenList? = { nil }
  ) {
    self.init(
      specifier: specifierBuilder(),
      name: name.map(TokenSyntax.identifier),
      assignToken: assignToken,
      expression: expression,
      trailingComma: trailingComma
    )
  }

  func buildClosureCaptureItem(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureItemSyntax {
    let result = SyntaxFactory.makeClosureCaptureItem(
      specifier: specifier?.buildTokenList(format: format, leadingTrivia: nil),
      name: name,
      assignToken: assignToken,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureCaptureItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureCaptureItem`.
  public func createClosureCaptureItem() -> ClosureCaptureItem {
    return self
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

  /// Creates a `ClosureCaptureSignature` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - items: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    items: ExpressibleAsClosureCaptureItemList? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
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
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ExpressibleAsClosureCaptureItemList? = { nil }
  ) {
    self.init(
      leftSquare: leftSquare,
      items: itemsBuilder(),
      rightSquare: rightSquare
    )
  }

  func buildClosureCaptureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureSignatureSyntax {
    let result = SyntaxFactory.makeClosureCaptureSignature(
      leftSquare: leftSquare,
      items: items?.buildClosureCaptureItemList(format: format, leadingTrivia: nil),
      rightSquare: rightSquare
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureCaptureSignature(format: format, leadingTrivia: leadingTrivia)
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
public struct ClosureParam: SyntaxBuildable, ExpressibleAsClosureParam {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// Creates a `ClosureParam` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildClosureParam(format: Format, leadingTrivia: Trivia? = nil) -> ClosureParamSyntax {
    let result = SyntaxFactory.makeClosureParam(
      name: name,
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsClosureParam`.
  public func createClosureParam() -> ClosureParam {
    return self
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
    attributes: ExpressibleAsAttributeList? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsTok: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
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
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: String?,
    throwsTok: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      capture: capture,
      input: input,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsTok: throwsTok,
      output: output,
      inTok: inTok
    )
  }

  func buildClosureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureSignatureSyntax {
    let result = SyntaxFactory.makeClosureSignature(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      capture: capture?.buildClosureCaptureSignature(format: format, leadingTrivia: nil),
      input: input?.buildSyntax(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      throwsTok: throwsTok,
      output: output?.buildReturnClause(format: format, leadingTrivia: nil),
      inTok: inTok
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildClosureSignature(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ClosureExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - signature: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      leftBrace: leftBrace,
      signature: signature,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildClosureExpr(format: Format, leadingTrivia: Trivia? = nil) -> ClosureExprSyntax {
    let result = SyntaxFactory.makeClosureExpr(
      leftBrace: leftBrace,
      signature: signature?.buildClosureSignature(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildClosureExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `UnresolvedPatternExpr` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  public init(
    pattern: ExpressibleAsPatternBuildable
  ) {
    self.pattern = pattern.createPatternBuildable()
  }


  func buildUnresolvedPatternExpr(format: Format, leadingTrivia: Trivia? = nil) -> UnresolvedPatternExprSyntax {
    let result = SyntaxFactory.makeUnresolvedPatternExpr(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildUnresolvedPatternExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MultipleTrailingClosureElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - closure: 
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    closure: ExpressibleAsClosureExpr
  ) {
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.closure = closure.createClosureExpr()
  }


  func buildMultipleTrailingClosureElement(format: Format, leadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementSyntax {
    let result = SyntaxFactory.makeMultipleTrailingClosureElement(
      label: label,
      colon: colon,
      closure: closure.buildClosureExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMultipleTrailingClosureElement(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `FunctionCallExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
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
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> ExpressibleAsMultipleTrailingClosureElementList? = { nil }
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

  func buildFunctionCallExpr(format: Format, leadingTrivia: Trivia? = nil) -> FunctionCallExprSyntax {
    let result = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildFunctionCallExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SubscriptExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftBracket: 
  ///   - argumentList: 
  ///   - rightBracket: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    argumentList: ExpressibleAsTupleExprElementList,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
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
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> ExpressibleAsMultipleTrailingClosureElementList? = { nil }
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

  func buildSubscriptExpr(format: Format, leadingTrivia: Trivia? = nil) -> SubscriptExprSyntax {
    let result = SyntaxFactory.makeSubscriptExpr(
      calledExpression: calledExpression.buildExpr(format: format, leadingTrivia: nil),
      leftBracket: leftBracket,
      argumentList: argumentList.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightBracket: rightBracket,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format, leadingTrivia: nil),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSubscriptExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OptionalChainingExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - questionMark: 
  public init(
    expression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  func buildOptionalChainingExpr(format: Format, leadingTrivia: Trivia? = nil) -> OptionalChainingExprSyntax {
    let result = SyntaxFactory.makeOptionalChainingExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildOptionalChainingExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ForcedValueExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - exclamationMark: 
  public init(
    expression: ExpressibleAsExprBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  func buildForcedValueExpr(format: Format, leadingTrivia: Trivia? = nil) -> ForcedValueExprSyntax {
    let result = SyntaxFactory.makeForcedValueExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildForcedValueExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PostfixUnaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - operatorToken: 
  public init(
    expression: ExpressibleAsExprBuildable,
    operatorToken: TokenSyntax
  ) {
    self.expression = expression.createExprBuildable()
    self.operatorToken = operatorToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    expression: ExpressibleAsExprBuildable,
    operatorToken: String
  ) {
    self.init(
      expression: expression,
      operatorToken: TokenSyntax.postfixOperator(operatorToken)
    )
  }

  func buildPostfixUnaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> PostfixUnaryExprSyntax {
    let result = SyntaxFactory.makePostfixUnaryExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      operatorToken: operatorToken
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPostfixUnaryExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SpecializeExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - genericArgumentClause: 
  public init(
    expression: ExpressibleAsExprBuildable,
    genericArgumentClause: ExpressibleAsGenericArgumentClause
  ) {
    self.expression = expression.createExprBuildable()
    self.genericArgumentClause = genericArgumentClause.createGenericArgumentClause()
  }


  func buildSpecializeExpr(format: Format, leadingTrivia: Trivia? = nil) -> SpecializeExprSyntax {
    let result = SyntaxFactory.makeSpecializeExpr(
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      genericArgumentClause: genericArgumentClause.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildSpecializeExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `StringSegment` using the provided parameters.
  /// - Parameters:
  ///   - content: 
  public init(
    content: TokenSyntax
  ) {
    self.content = content
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    content: String
  ) {
    self.init(
      content: TokenSyntax.stringSegment(content)
    )
  }

  func buildStringSegment(format: Format, leadingTrivia: Trivia? = nil) -> StringSegmentSyntax {
    let result = SyntaxFactory.makeStringSegment(
      content: content
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildStringSegment(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ExpressionSegment` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - delimiter: 
  ///   - leftParen: 
  ///   - expressions: 
  ///   - rightParen: 
  public init(
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: TokenSyntax? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    expressions: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`
  ) {
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
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: String?,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
    @TupleExprElementListBuilder expressionsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      backslash: backslash,
      delimiter: delimiter.map(TokenSyntax.rawStringDelimiter),
      leftParen: leftParen,
      expressions: expressionsBuilder(),
      rightParen: rightParen
    )
  }

  func buildExpressionSegment(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionSegmentSyntax {
    let result = SyntaxFactory.makeExpressionSegment(
      backslash: backslash,
      delimiter: delimiter,
      leftParen: leftParen,
      expressions: expressions.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildExpressionSegment(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `StringLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - openDelimiter: 
  ///   - openQuote: 
  ///   - segments: 
  ///   - closeQuote: 
  ///   - closeDelimiter: 
  public init(
    openDelimiter: TokenSyntax? = nil,
    openQuote: TokenSyntax,
    segments: ExpressibleAsStringLiteralSegments,
    closeQuote: TokenSyntax,
    closeDelimiter: TokenSyntax? = nil
  ) {
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
    openDelimiter: String?,
    openQuote: TokenSyntax,
    closeQuote: TokenSyntax,
    closeDelimiter: String?,
    @StringLiteralSegmentsBuilder segmentsBuilder: () -> ExpressibleAsStringLiteralSegments = { StringLiteralSegments([]) }
  ) {
    self.init(
      openDelimiter: openDelimiter.map(TokenSyntax.rawStringDelimiter),
      openQuote: openQuote,
      segments: segmentsBuilder(),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter.map(TokenSyntax.rawStringDelimiter)
    )
  }

  func buildStringLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> StringLiteralExprSyntax {
    let result = SyntaxFactory.makeStringLiteralExpr(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments.buildStringLiteralSegments(format: format, leadingTrivia: nil),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildStringLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `RegexLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - regex: 
  public init(
    regex: TokenSyntax
  ) {
    self.regex = regex
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    regex: String
  ) {
    self.init(
      regex: TokenSyntax.regexLiteral(regex)
    )
  }

  func buildRegexLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> RegexLiteralExprSyntax {
    let result = SyntaxFactory.makeRegexLiteralExpr(
      regex: regex
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildRegexLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `KeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - rootExpr: 
  ///   - expression: 
  public init(
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    rootExpr: ExpressibleAsExprBuildable? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.backslash = backslash
    assert(backslash.text == "\\")
    self.rootExpr = rootExpr?.createExprBuildable()
    self.expression = expression.createExprBuildable()
  }


  func buildKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathExprSyntax {
    let result = SyntaxFactory.makeKeyPathExpr(
      backslash: backslash,
      rootExpr: rootExpr?.buildExpr(format: format, leadingTrivia: nil),
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `KeyPathBaseExpr` using the provided parameters.
  /// - Parameters:
  ///   - period: 
  public init(
    period: TokenSyntax = TokenSyntax.`period`
  ) {
    self.period = period
    assert(period.text == ".")
  }


  func buildKeyPathBaseExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathBaseExprSyntax {
    let result = SyntaxFactory.makeKeyPathBaseExpr(
      period: period
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildKeyPathBaseExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ObjcNamePiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - dot: 
  public init(
    name: TokenSyntax,
    dot: TokenSyntax? = nil
  ) {
    self.name = name
    self.dot = dot
    assert(dot == nil || dot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    name: String,
    dot: TokenSyntax? = nil
  ) {
    self.init(
      name: TokenSyntax.identifier(name),
      dot: dot
    )
  }

  func buildObjcNamePiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjcNamePieceSyntax {
    let result = SyntaxFactory.makeObjcNamePiece(
      name: name,
      dot: dot
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildObjcNamePiece(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ObjcKeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - keyPath: 
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: ExpressibleAsObjcName,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.keyPath = keyPath
    assert(keyPath.text == "#keyPath")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.name = name.createObjcName()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @ObjcNameBuilder nameBuilder: () -> ExpressibleAsObjcName = { ObjcName([]) }
  ) {
    self.init(
      keyPath: keyPath,
      leftParen: leftParen,
      name: nameBuilder(),
      rightParen: rightParen
    )
  }

  func buildObjcKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjcKeyPathExprSyntax {
    let result = SyntaxFactory.makeObjcKeyPathExpr(
      keyPath: keyPath,
      leftParen: leftParen,
      name: name.buildObjcName(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjcKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ObjcSelectorExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundSelector: 
  ///   - leftParen: 
  ///   - kind: 
  ///   - colon: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: String?,
    colon: TokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
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

  func buildObjcSelectorExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjcSelectorExprSyntax {
    let result = SyntaxFactory.makeObjcSelectorExpr(
      poundSelector: poundSelector,
      leftParen: leftParen,
      kind: kind,
      colon: colon,
      name: name.buildExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjcSelectorExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PostfixIfConfigExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - config: 
  public init(
    base: ExpressibleAsExprBuildable? = nil,
    config: ExpressibleAsIfConfigDecl
  ) {
    self.base = base?.createExprBuildable()
    self.config = config.createIfConfigDecl()
  }


  func buildPostfixIfConfigExpr(format: Format, leadingTrivia: Trivia? = nil) -> PostfixIfConfigExprSyntax {
    let result = SyntaxFactory.makePostfixIfConfigExpr(
      base: base?.buildExpr(format: format, leadingTrivia: nil),
      config: config.buildIfConfigDecl(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildPostfixIfConfigExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `EditorPlaceholderExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  public init(
    identifier: TokenSyntax
  ) {
    self.identifier = identifier
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    identifier: String
  ) {
    self.init(
      identifier: TokenSyntax.identifier(identifier)
    )
  }

  func buildEditorPlaceholderExpr(format: Format, leadingTrivia: Trivia? = nil) -> EditorPlaceholderExprSyntax {
    let result = SyntaxFactory.makeEditorPlaceholderExpr(
      identifier: identifier
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildEditorPlaceholderExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ObjectLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) }
  ) {
    self.init(
      identifier: identifier,
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen
    )
  }

  func buildObjectLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjectLiteralExprSyntax {
    let result = SyntaxFactory.makeObjectLiteralExpr(
      identifier: identifier,
      leftParen: leftParen,
      arguments: arguments.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `ExprBuildable`.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let result = buildObjectLiteralExpr(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TypeInitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsTypeBuildable
  ) {
    self.equal = equal
    assert(equal.text == "=")
    self.value = value.createTypeBuildable()
  }


  func buildTypeInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInitializerClauseSyntax {
    let result = SyntaxFactory.makeTypeInitializerClause(
      equal: equal,
      value: value.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeInitializerClause(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
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
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      typealiasKeyword: typealiasKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }

  func buildTypealiasDecl(format: Format, leadingTrivia: Trivia? = nil) -> TypealiasDeclSyntax {
    let result = SyntaxFactory.makeTypealiasDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      typealiasKeyword: typealiasKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildTypealiasDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: TokenSyntax,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
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
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: String,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: TokenSyntax.identifier(identifier),
      inheritanceClause: inheritanceClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }

  func buildAssociatedtypeDecl(format: Format, leadingTrivia: Trivia? = nil) -> AssociatedtypeDeclSyntax {
    let result = SyntaxFactory.makeAssociatedtypeDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: identifier,
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildAssociatedtypeDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - parameterList: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    parameterList: ExpressibleAsFunctionParameterList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> ExpressibleAsFunctionParameterList = { FunctionParameterList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      parameterList: parameterListBuilder(),
      rightParen: rightParen
    )
  }

  func buildParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> ParameterClauseSyntax {
    let result = SyntaxFactory.makeParameterClause(
      leftParen: leftParen,
      parameterList: parameterList.buildFunctionParameterList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildParameterClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ReturnClause` using the provided parameters.
  /// - Parameters:
  ///   - arrow: 
  ///   - returnType: 
  public init(
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.arrow = arrow
    assert(arrow.text == "->")
    self.returnType = returnType.createTypeBuildable()
  }


  func buildReturnClause(format: Format, leadingTrivia: Trivia? = nil) -> ReturnClauseSyntax {
    let result = SyntaxFactory.makeReturnClause(
      arrow: arrow,
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildReturnClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `FunctionSignature` using the provided parameters.
  /// - Parameters:
  ///   - input: 
  ///   - asyncOrReasyncKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - output: 
  public init(
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
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
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: String?,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.init(
      input: input,
      asyncOrReasyncKeyword: asyncOrReasyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output
    )
  }

  func buildFunctionSignature(format: Format, leadingTrivia: Trivia? = nil) -> FunctionSignatureSyntax {
    let result = SyntaxFactory.makeFunctionSignature(
      input: input.buildParameterClause(format: format, leadingTrivia: nil),
      asyncOrReasyncKeyword: asyncOrReasyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output?.buildReturnClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionSignature(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IfConfigClause` using the provided parameters.
  /// - Parameters:
  ///   - poundKeyword: 
  ///   - condition: 
  ///   - elements: 
  public init(
    poundKeyword: TokenSyntax,
    condition: ExpressibleAsExprBuildable? = nil,
    elements: ExpressibleAsSyntaxBuildable
  ) {
    self.poundKeyword = poundKeyword
    assert(poundKeyword.text == "#if" || poundKeyword.text == "#elseif" || poundKeyword.text == "#else")
    self.condition = condition?.createExprBuildable()
    self.elements = elements.createSyntaxBuildable()
  }


  func buildIfConfigClause(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigClauseSyntax {
    let result = SyntaxFactory.makeIfConfigClause(
      poundKeyword: poundKeyword,
      condition: condition?.buildExpr(format: format, leadingTrivia: nil),
      elements: elements.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildIfConfigClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IfConfigDecl` using the provided parameters.
  /// - Parameters:
  ///   - clauses: 
  ///   - poundEndif: 
  public init(
    clauses: ExpressibleAsIfConfigClauseList,
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`
  ) {
    self.clauses = clauses.createIfConfigClauseList()
    self.poundEndif = poundEndif
    assert(poundEndif.text == "#endif")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`,
    @IfConfigClauseListBuilder clausesBuilder: () -> ExpressibleAsIfConfigClauseList = { IfConfigClauseList([]) }
  ) {
    self.init(
      clauses: clausesBuilder(),
      poundEndif: poundEndif
    )
  }

  func buildIfConfigDecl(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigDeclSyntax {
    let result = SyntaxFactory.makeIfConfigDecl(
      clauses: clauses.buildIfConfigClauseList(format: format, leadingTrivia: nil),
      poundEndif: poundEndif
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildIfConfigDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundErrorDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundError: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    poundError: TokenSyntax = TokenSyntax.`poundError`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundError = poundError
    assert(poundError.text == "#error")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  func buildPoundErrorDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundErrorDeclSyntax {
    let result = SyntaxFactory.makePoundErrorDecl(
      poundError: poundError,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundErrorDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundWarningDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundWarning: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    poundWarning: TokenSyntax = TokenSyntax.`poundWarning`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundWarning = poundWarning
    assert(poundWarning.text == "#warning")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  func buildPoundWarningDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundWarningDeclSyntax {
    let result = SyntaxFactory.makePoundWarningDecl(
      poundWarning: poundWarning,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundWarningDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundSourceLocation` using the provided parameters.
  /// - Parameters:
  ///   - poundSourceLocation: 
  ///   - leftParen: 
  ///   - args: 
  ///   - rightParen: 
  public init(
    poundSourceLocation: TokenSyntax = TokenSyntax.`poundSourceLocation`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    args: ExpressibleAsPoundSourceLocationArgs? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundSourceLocation = poundSourceLocation
    assert(poundSourceLocation.text == "#sourceLocation")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.args = args?.createPoundSourceLocationArgs()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }


  func buildPoundSourceLocation(format: Format, leadingTrivia: Trivia? = nil) -> PoundSourceLocationSyntax {
    let result = SyntaxFactory.makePoundSourceLocation(
      poundSourceLocation: poundSourceLocation,
      leftParen: leftParen,
      args: args?.buildPoundSourceLocationArgs(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPoundSourceLocation(format: format, leadingTrivia: leadingTrivia)
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
    fileArgLabel: TokenSyntax,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: TokenSyntax,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: TokenSyntax,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: TokenSyntax
  ) {
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
    fileArgLabel: String,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: String,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: String,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: String
  ) {
    self.init(
      fileArgLabel: TokenSyntax.identifier(fileArgLabel),
      fileArgColon: fileArgColon,
      fileName: TokenSyntax.stringLiteral(fileName),
      comma: comma,
      lineArgLabel: TokenSyntax.identifier(lineArgLabel),
      lineArgColon: lineArgColon,
      lineNumber: TokenSyntax.integerLiteral(lineNumber)
    )
  }

  func buildPoundSourceLocationArgs(format: Format, leadingTrivia: Trivia? = nil) -> PoundSourceLocationArgsSyntax {
    let result = SyntaxFactory.makePoundSourceLocationArgs(
      fileArgLabel: fileArgLabel,
      fileArgColon: fileArgColon,
      fileName: fileName,
      comma: comma,
      lineArgLabel: lineArgLabel,
      lineArgColon: lineArgColon,
      lineNumber: lineNumber
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPoundSourceLocationArgs(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeclModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - detailLeftParen: 
  ///   - detail: 
  ///   - detailRightParen: 
  public init(
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: TokenSyntax? = nil,
    detailRightParen: TokenSyntax? = nil
  ) {
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
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: String?,
    detailRightParen: TokenSyntax? = nil
  ) {
    self.init(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail.map(TokenSyntax.identifier),
      detailRightParen: detailRightParen
    )
  }

  func buildDeclModifier(format: Format, leadingTrivia: Trivia? = nil) -> DeclModifierSyntax {
    let result = SyntaxFactory.makeDeclModifier(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail,
      detailRightParen: detailRightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclModifier(format: format, leadingTrivia: leadingTrivia)
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
public struct InheritedType: SyntaxBuildable, ExpressibleAsInheritedType {
  let typeName: TypeBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `InheritedType` using the provided parameters.
  /// - Parameters:
  ///   - typeName: 
  ///   - trailingComma: 
  public init(
    typeName: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.typeName = typeName.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildInheritedType(format: Format, leadingTrivia: Trivia? = nil) -> InheritedTypeSyntax {
    let result = SyntaxFactory.makeInheritedType(
      typeName: typeName.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildInheritedType(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsInheritedType`.
  public func createInheritedType() -> InheritedType {
    return self
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

  /// Creates a `TypeInheritanceClause` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - inheritedTypeCollection: 
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    inheritedTypeCollection: ExpressibleAsInheritedTypeList
  ) {
    self.colon = colon
    assert(colon.text == ":")
    self.inheritedTypeCollection = inheritedTypeCollection.createInheritedTypeList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    @InheritedTypeListBuilder inheritedTypeCollectionBuilder: () -> ExpressibleAsInheritedTypeList = { InheritedTypeList([]) }
  ) {
    self.init(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollectionBuilder()
    )
  }

  func buildTypeInheritanceClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInheritanceClauseSyntax {
    let result = SyntaxFactory.makeTypeInheritanceClause(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollection.buildInheritedTypeList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeInheritanceClause(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    classOrActorKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
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
    classOrActorKeyword: TokenSyntax,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      classOrActorKeyword: classOrActorKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }

  func buildClassDecl(format: Format, leadingTrivia: Trivia? = nil) -> ClassDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildClassDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
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
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      structKeyword: structKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }

  func buildStructDecl(format: Format, leadingTrivia: Trivia? = nil) -> StructDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildStructDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: TokenSyntax,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
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
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: String,
    primaryAssociatedTypeClause: ExpressibleAsPrimaryAssociatedTypeClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      protocolKeyword: protocolKeyword,
      identifier: TokenSyntax.identifier(identifier),
      primaryAssociatedTypeClause: primaryAssociatedTypeClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }

  func buildProtocolDecl(format: Format, leadingTrivia: Trivia? = nil) -> ProtocolDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildProtocolDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
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
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
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

  func buildExtensionDecl(format: Format, leadingTrivia: Trivia? = nil) -> ExtensionDeclSyntax {
    let result = SyntaxFactory.makeExtensionDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      extensionKeyword: extensionKeyword,
      extendedType: extendedType.buildType(format: format, leadingTrivia: nil),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format, leadingTrivia: nil),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil),
      members: members.buildMemberDeclBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildExtensionDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MemberDeclBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - members: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    members: ExpressibleAsMemberDeclList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleAsMemberDeclList = { MemberDeclList([]) }
  ) {
    self.init(
      leftBrace: leftBrace,
      members: membersBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildMemberDeclBlock(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclBlockSyntax {
    let result = SyntaxFactory.makeMemberDeclBlock(
      leftBrace: leftBrace,
      members: members.buildMemberDeclList(format: format._indented(), leadingTrivia: nil),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMemberDeclBlock(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MemberDeclListItem` using the provided parameters.
  /// - Parameters:
  ///   - decl: The declaration of the type member.
  ///   - semicolon: An optional trailing semicolon.
  public init(
    decl: ExpressibleAsDeclBuildable,
    semicolon: TokenSyntax? = nil
  ) {
    self.decl = decl.createDeclBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || semicolon!.text == ";")
  }


  func buildMemberDeclListItem(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclListItemSyntax {
    let result = SyntaxFactory.makeMemberDeclListItem(
      decl: decl.buildDecl(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMemberDeclListItem(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SourceFile` using the provided parameters.
  /// - Parameters:
  ///   - statements: 
  ///   - eofToken: 
  public init(
    statements: ExpressibleAsCodeBlockItemList,
    eofToken: TokenSyntax
  ) {
    self.statements = statements.createCodeBlockItemList()
    self.eofToken = eofToken
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    eofToken: TokenSyntax,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      statements: statementsBuilder(),
      eofToken: eofToken
    )
  }

  func buildSourceFile(format: Format, leadingTrivia: Trivia? = nil) -> SourceFileSyntax {
    let result = SyntaxFactory.makeSourceFile(
      statements: statements.buildCodeBlockItemList(format: format, leadingTrivia: nil),
      eofToken: eofToken
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSourceFile(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `InitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsExprBuildable
  ) {
    self.equal = equal
    assert(equal.text == "=")
    self.value = value.createExprBuildable()
  }


  func buildInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> InitializerClauseSyntax {
    let result = SyntaxFactory.makeInitializerClause(
      equal: equal,
      value: value.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildInitializerClause(format: format, leadingTrivia: leadingTrivia)
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
public struct FunctionParameter: SyntaxBuildable, ExpressibleAsFunctionParameter {
  let attributes: AttributeList?
  let firstName: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable?
  let ellipsis: TokenSyntax?
  let defaultArgument: InitializerClause?
  let trailingComma: TokenSyntax?

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
    attributes: ExpressibleAsAttributeList? = nil,
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
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

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
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

  func buildFunctionParameter(format: Format, leadingTrivia: Trivia? = nil) -> FunctionParameterSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsFunctionParameter`.
  public func createFunctionParameter() -> FunctionParameter {
    return self
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
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
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
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

  func buildFunctionDecl(format: Format, leadingTrivia: Trivia? = nil) -> FunctionDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildFunctionDecl(format: format, leadingTrivia: leadingTrivia)
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
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    parameters: ExpressibleAsParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
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

  func buildInitializerDecl(format: Format, leadingTrivia: Trivia? = nil) -> InitializerDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildInitializerDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeinitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - deinitKeyword: 
  ///   - body: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleAsCodeBlock
  ) {
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
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleAsCodeBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      deinitKeyword: deinitKeyword,
      body: body
    )
  }

  func buildDeinitializerDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeinitializerDeclSyntax {
    let result = SyntaxFactory.makeDeinitializerDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      deinitKeyword: deinitKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildDeinitializerDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    indices: ExpressibleAsParameterClause,
    result: ExpressibleAsReturnClause,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil
  ) {
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

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    indices: ExpressibleAsParameterClause,
    result: ExpressibleAsReturnClause,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
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

  func buildSubscriptDecl(format: Format, leadingTrivia: Trivia? = nil) -> SubscriptDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildSubscriptDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AccessLevelModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - leftParen: 
  ///   - modifier: 
  ///   - rightParen: 
  public init(
    name: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    modifier: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil
  ) {
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
    name: String,
    leftParen: TokenSyntax? = nil,
    modifier: String?,
    rightParen: TokenSyntax? = nil
  ) {
    self.init(
      name: TokenSyntax.identifier(name),
      leftParen: leftParen,
      modifier: modifier.map(TokenSyntax.identifier),
      rightParen: rightParen
    )
  }

  func buildAccessLevelModifier(format: Format, leadingTrivia: Trivia? = nil) -> AccessLevelModifierSyntax {
    let result = SyntaxFactory.makeAccessLevelModifier(
      name: name,
      leftParen: leftParen,
      modifier: modifier,
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessLevelModifier(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AccessPathComponent` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingDot: 
  public init(
    name: TokenSyntax,
    trailingDot: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingDot = trailingDot
    assert(trailingDot == nil || trailingDot!.text == ".")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    name: String,
    trailingDot: TokenSyntax? = nil
  ) {
    self.init(
      name: TokenSyntax.identifier(name),
      trailingDot: trailingDot
    )
  }

  func buildAccessPathComponent(format: Format, leadingTrivia: Trivia? = nil) -> AccessPathComponentSyntax {
    let result = SyntaxFactory.makeAccessPathComponent(
      name: name,
      trailingDot: trailingDot
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessPathComponent(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ImportDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - importTok: 
  ///   - importKind: 
  ///   - path: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    importTok: TokenSyntax = TokenSyntax.`import`,
    importKind: TokenSyntax? = nil,
    path: ExpressibleAsAccessPath
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.importTok = importTok
    assert(importTok.text == "import")
    self.importKind = importKind
    assert(importKind == nil || importKind!.text == "typealias" || importKind!.text == "struct" || importKind!.text == "class" || importKind!.text == "enum" || importKind!.text == "protocol" || importKind!.text == "var" || importKind!.text == "let" || importKind!.text == "func")
    self.path = path.createAccessPath()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    importTok: TokenSyntax = TokenSyntax.`import`,
    importKind: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil },
    @AccessPathBuilder pathBuilder: () -> ExpressibleAsAccessPath = { AccessPath([]) }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      importTok: importTok,
      importKind: importKind,
      path: pathBuilder()
    )
  }

  func buildImportDecl(format: Format, leadingTrivia: Trivia? = nil) -> ImportDeclSyntax {
    let result = SyntaxFactory.makeImportDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      importTok: importTok,
      importKind: importKind,
      path: path.buildAccessPath(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildImportDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AccessorParameter` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: TokenSyntax,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: String,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      name: TokenSyntax.identifier(name),
      rightParen: rightParen
    )
  }

  func buildAccessorParameter(format: Format, leadingTrivia: Trivia? = nil) -> AccessorParameterSyntax {
    let result = SyntaxFactory.makeAccessorParameter(
      leftParen: leftParen,
      name: name,
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessorParameter(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsKeyword: TokenSyntax? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
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
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: TokenSyntax? = nil,
    body: ExpressibleAsCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifier: modifier,
      accessorKind: accessorKind,
      parameter: parameter,
      asyncKeyword: asyncKeyword.map(TokenSyntax.contextualKeyword),
      throwsKeyword: throwsKeyword,
      body: body
    )
  }

  func buildAccessorDecl(format: Format, leadingTrivia: Trivia? = nil) -> AccessorDeclSyntax {
    let result = SyntaxFactory.makeAccessorDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifier: modifier?.buildDeclModifier(format: format, leadingTrivia: nil),
      accessorKind: accessorKind,
      parameter: parameter?.buildAccessorParameter(format: format, leadingTrivia: nil),
      asyncKeyword: asyncKeyword,
      throwsKeyword: throwsKeyword,
      body: body?.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildAccessorDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AccessorBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - accessors: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    accessors: ExpressibleAsAccessorList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace
    assert(leftBrace.text == "{")
    self.accessors = accessors.createAccessorList()
    self.rightBrace = rightBrace
    assert(rightBrace.text == "}")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @AccessorListBuilder accessorsBuilder: () -> ExpressibleAsAccessorList = { AccessorList([]) }
  ) {
    self.init(
      leftBrace: leftBrace,
      accessors: accessorsBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildAccessorBlock(format: Format, leadingTrivia: Trivia? = nil) -> AccessorBlockSyntax {
    let result = SyntaxFactory.makeAccessorBlock(
      leftBrace: leftBrace,
      accessors: accessors.buildAccessorList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAccessorBlock(format: format, leadingTrivia: leadingTrivia)
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
public struct PatternBinding: SyntaxBuildable, ExpressibleAsPatternBinding {
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause?
  let accessor: SyntaxBuildable?
  let trailingComma: TokenSyntax?

  /// Creates a `PatternBinding` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  ///   - accessor: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
    self.accessor = accessor?.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildPatternBinding(format: Format, leadingTrivia: Trivia? = nil) -> PatternBindingSyntax {
    let result = SyntaxFactory.makePatternBinding(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil),
      accessor: accessor?.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPatternBinding(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPatternBinding`.
  public func createPatternBinding() -> PatternBinding {
    return self
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

  /// Creates a `VariableDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - letOrVarKeyword: 
  ///   - bindings: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    letOrVarKeyword: TokenSyntax,
    bindings: ExpressibleAsPatternBindingList
  ) {
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
    letOrVarKeyword: TokenSyntax,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil },
    @PatternBindingListBuilder bindingsBuilder: () -> ExpressibleAsPatternBindingList = { PatternBindingList([]) }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindingsBuilder()
    )
  }

  func buildVariableDecl(format: Format, leadingTrivia: Trivia? = nil) -> VariableDeclSyntax {
    let result = SyntaxFactory.makeVariableDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindings.buildPatternBindingList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildVariableDecl(format: format, leadingTrivia: leadingTrivia)
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
public struct EnumCaseElement: SyntaxBuildable, ExpressibleAsEnumCaseElement {
  let identifier: TokenSyntax
  let associatedValue: ParameterClause?
  let rawValue: InitializerClause?
  let trailingComma: TokenSyntax?

  /// Creates a `EnumCaseElement` using the provided parameters.
  /// - Parameters:
  ///   - identifier: The name of this case.
  ///   - associatedValue: The set of associated values of the case.
  ///   - rawValue: The raw value of this enum element, if present.
  ///   - trailingComma: The trailing comma of this element, if the case hasmultiple elements.
  public init(
    identifier: TokenSyntax,
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
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
    identifier: String,
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      identifier: TokenSyntax.identifier(identifier),
      associatedValue: associatedValue,
      rawValue: rawValue,
      trailingComma: trailingComma
    )
  }

  func buildEnumCaseElement(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseElementSyntax {
    let result = SyntaxFactory.makeEnumCaseElement(
      identifier: identifier,
      associatedValue: associatedValue?.buildParameterClause(format: format, leadingTrivia: nil),
      rawValue: rawValue?.buildInitializerClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildEnumCaseElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsEnumCaseElement`.
  public func createEnumCaseElement() -> EnumCaseElement {
    return self
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

  /// Creates a `EnumCaseDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the case declaration.
  ///   - modifiers: The declaration modifiers applied to the case declaration.
  ///   - caseKeyword: The `case` keyword for this case.
  ///   - elements: The elements this case declares.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    elements: ExpressibleAsEnumCaseElementList
  ) {
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
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil },
    @EnumCaseElementListBuilder elementsBuilder: () -> ExpressibleAsEnumCaseElementList = { EnumCaseElementList([]) }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      caseKeyword: caseKeyword,
      elements: elementsBuilder()
    )
  }

  func buildEnumCaseDecl(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseDeclSyntax {
    let result = SyntaxFactory.makeEnumCaseDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      caseKeyword: caseKeyword,
      elements: elements.buildEnumCaseElementList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildEnumCaseDecl(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: TokenSyntax,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
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
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: String,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      enumKeyword: enumKeyword,
      identifier: TokenSyntax.identifier(identifier),
      genericParameters: genericParameters,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }

  func buildEnumDecl(format: Format, leadingTrivia: Trivia? = nil) -> EnumDeclSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildEnumDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OperatorDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the 'operator' declaration.
  ///   - modifiers: The declaration modifiers applied to the 'operator'declaration.
  ///   - operatorKeyword: 
  ///   - identifier: 
  ///   - operatorPrecedenceAndTypes: Optionally specify a precedence group and designated types.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.operatorKeyword = operatorKeyword
    assert(operatorKeyword.text == "operator")
    self.identifier = identifier
    self.operatorPrecedenceAndTypes = operatorPrecedenceAndTypes?.createOperatorPrecedenceAndTypes()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes
    )
  }

  func buildOperatorDecl(format: Format, leadingTrivia: Trivia? = nil) -> OperatorDeclSyntax {
    let result = SyntaxFactory.makeOperatorDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes?.buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildOperatorDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OperatorPrecedenceAndTypes` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - precedenceGroupAndDesignatedTypes: The precedence group and designated types for this operator
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    precedenceGroupAndDesignatedTypes: ExpressibleAsIdentifierList
  ) {
    self.colon = colon
    assert(colon.text == ":")
    self.precedenceGroupAndDesignatedTypes = precedenceGroupAndDesignatedTypes.createIdentifierList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    @IdentifierListBuilder precedenceGroupAndDesignatedTypesBuilder: () -> ExpressibleAsIdentifierList = { IdentifierList([]) }
  ) {
    self.init(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypesBuilder()
    )
  }

  func buildOperatorPrecedenceAndTypes(format: Format, leadingTrivia: Trivia? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let result = SyntaxFactory.makeOperatorPrecedenceAndTypes(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypes.buildIdentifierList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: leadingTrivia)
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
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: TokenSyntax,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
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
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: String,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleAsModifierList? = { nil },
    @PrecedenceGroupAttributeListBuilder groupAttributesBuilder: () -> ExpressibleAsPrecedenceGroupAttributeList = { PrecedenceGroupAttributeList([]) }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: TokenSyntax.identifier(identifier),
      leftBrace: leftBrace,
      groupAttributes: groupAttributesBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildPrecedenceGroupDecl(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupDeclSyntax {
    let result = SyntaxFactory.makePrecedenceGroupDecl(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      modifiers: modifiers?.buildModifierList(format: format, leadingTrivia: nil),
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: identifier,
      leftBrace: leftBrace,
      groupAttributes: groupAttributes.buildPrecedenceGroupAttributeList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `DeclBuildable`.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let result = buildPrecedenceGroupDecl(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrecedenceGroupRelation` using the provided parameters.
  /// - Parameters:
  ///   - higherThanOrLowerThan: The relation to specified other precedence groups.
  ///   - colon: 
  ///   - otherNames: The name of other precedence group to which this precedencegroup relates.
  public init(
    higherThanOrLowerThan: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
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
    higherThanOrLowerThan: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @PrecedenceGroupNameListBuilder otherNamesBuilder: () -> ExpressibleAsPrecedenceGroupNameList = { PrecedenceGroupNameList([]) }
  ) {
    self.init(
      higherThanOrLowerThan: TokenSyntax.identifier(higherThanOrLowerThan),
      colon: colon,
      otherNames: otherNamesBuilder()
    )
  }

  func buildPrecedenceGroupRelation(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupRelationSyntax {
    let result = SyntaxFactory.makePrecedenceGroupRelation(
      higherThanOrLowerThan: higherThanOrLowerThan,
      colon: colon,
      otherNames: otherNames.buildPrecedenceGroupNameList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupRelation(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrecedenceGroupNameElement` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    name: String,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      name: TokenSyntax.identifier(name),
      trailingComma: trailingComma
    )
  }

  func buildPrecedenceGroupNameElement(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupNameElementSyntax {
    let result = SyntaxFactory.makePrecedenceGroupNameElement(
      name: name,
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupNameElement(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrecedenceGroupAssignment` using the provided parameters.
  /// - Parameters:
  ///   - assignmentKeyword: 
  ///   - colon: 
  ///   - flag: When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.
  public init(
    assignmentKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
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
    assignmentKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
    self.init(
      assignmentKeyword: TokenSyntax.identifier(assignmentKeyword),
      colon: colon,
      flag: flag
    )
  }

  func buildPrecedenceGroupAssignment(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssignmentSyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssignment(
      assignmentKeyword: assignmentKeyword,
      colon: colon,
      flag: flag
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupAssignment(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrecedenceGroupAssociativity` using the provided parameters.
  /// - Parameters:
  ///   - associativityKeyword: 
  ///   - colon: 
  ///   - value: Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all
  public init(
    associativityKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax
  ) {
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
    associativityKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: String
  ) {
    self.init(
      associativityKeyword: TokenSyntax.identifier(associativityKeyword),
      colon: colon,
      value: TokenSyntax.identifier(value)
    )
  }

  func buildPrecedenceGroupAssociativity(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssociativitySyntax {
    let result = SyntaxFactory.makePrecedenceGroupAssociativity(
      associativityKeyword: associativityKeyword,
      colon: colon,
      value: value
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrecedenceGroupAssociativity(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `CustomAttribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList? = nil,
    rightParen: TokenSyntax? = nil
  ) {
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
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList? = { nil }
  ) {
    self.init(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen
    )
  }

  func buildCustomAttribute(format: Format, leadingTrivia: Trivia? = nil) -> CustomAttributeSyntax {
    let result = SyntaxFactory.makeCustomAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName.buildType(format: format, leadingTrivia: nil),
      leftParen: leftParen,
      argumentList: argumentList?.buildTupleExprElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCustomAttribute(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `Attribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: If the attribute takes arguments, the opening parenthesis.
  ///   - argument: The arguments of the attribute. In case the attributetakes multiple arguments, they are gather in theappropriate takes first.
  ///   - rightParen: If the attribute takes arguments, the closing parenthesis.
  ///   - tokenList: 
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    rightParen: TokenSyntax? = nil,
    tokenList: ExpressibleAsTokenList? = nil
  ) {
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

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    rightParen: TokenSyntax? = nil,
    @TokenListBuilder tokenListBuilder: () -> ExpressibleAsTokenList? = { nil }
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

  func buildAttribute(format: Format, leadingTrivia: Trivia? = nil) -> AttributeSyntax {
    let result = SyntaxFactory.makeAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argument: argument?.buildSyntax(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      tokenList: tokenList?.buildTokenList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAttribute(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AvailabilityEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - availabilityList: 
  ///   - semicolon: 
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
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
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`,
    @AvailabilitySpecListBuilder availabilityListBuilder: () -> ExpressibleAsAvailabilitySpecList = { AvailabilitySpecList([]) }
  ) {
    self.init(
      label: TokenSyntax.identifier(label),
      colon: colon,
      availabilityList: availabilityListBuilder(),
      semicolon: semicolon
    )
  }

  func buildAvailabilityEntry(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityEntrySyntax {
    let result = SyntaxFactory.makeAvailabilityEntry(
      label: label,
      colon: colon,
      availabilityList: availabilityList.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      semicolon: semicolon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityEntry(format: format, leadingTrivia: leadingTrivia)
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
public struct LabeledSpecializeEntry: SyntaxBuildable, ExpressibleAsLabeledSpecializeEntry {
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax
  let trailingComma: TokenSyntax?

  /// Creates a `LabeledSpecializeEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - value: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
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
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      label: TokenSyntax.identifier(label),
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
  }

  func buildLabeledSpecializeEntry(format: Format, leadingTrivia: Trivia? = nil) -> LabeledSpecializeEntrySyntax {
    let result = SyntaxFactory.makeLabeledSpecializeEntry(
      label: label,
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildLabeledSpecializeEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsLabeledSpecializeEntry`.
  public func createLabeledSpecializeEntry() -> LabeledSpecializeEntry {
    return self
  }

  /// `LabeledSpecializeEntry` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
/// A labeled argument for the `@_specialize` attribute with a functiondecl value like`target: myFunc(_:)`
public struct TargetFunctionEntry: SyntaxBuildable, ExpressibleAsTargetFunctionEntry {
  let label: TokenSyntax
  let colon: TokenSyntax
  let delcname: DeclName
  let trailingComma: TokenSyntax?

  /// Creates a `TargetFunctionEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - delcname: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleAsDeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.delcname = delcname.createDeclName()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleAsDeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      label: TokenSyntax.identifier(label),
      colon: colon,
      delcname: delcname,
      trailingComma: trailingComma
    )
  }

  func buildTargetFunctionEntry(format: Format, leadingTrivia: Trivia? = nil) -> TargetFunctionEntrySyntax {
    let result = SyntaxFactory.makeTargetFunctionEntry(
      label: label,
      colon: colon,
      delcname: delcname.buildDeclName(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTargetFunctionEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTargetFunctionEntry`.
  public func createTargetFunctionEntry() -> TargetFunctionEntry {
    return self
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

  /// Creates a `NamedAttributeStringArgument` using the provided parameters.
  /// - Parameters:
  ///   - nameTok: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - stringOrDeclname: 
  public init(
    nameTok: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    stringOrDeclname: ExpressibleAsSyntaxBuildable
  ) {
    self.nameTok = nameTok
    self.colon = colon
    assert(colon.text == ":")
    self.stringOrDeclname = stringOrDeclname.createSyntaxBuildable()
  }


  func buildNamedAttributeStringArgument(format: Format, leadingTrivia: Trivia? = nil) -> NamedAttributeStringArgumentSyntax {
    let result = SyntaxFactory.makeNamedAttributeStringArgument(
      nameTok: nameTok,
      colon: colon,
      stringOrDeclname: stringOrDeclname.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildNamedAttributeStringArgument(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeclName` using the provided parameters.
  /// - Parameters:
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  func buildDeclName(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameSyntax {
    let result = SyntaxFactory.makeDeclName(
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDeclName(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ImplementsAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - type: The type for which the method with this attributeimplements a requirement.
  ///   - comma: The comma separating the type and method name
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    type: ExpressibleAsSimpleTypeIdentifier,
    comma: TokenSyntax = TokenSyntax.`comma`,
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.type = type.createSimpleTypeIdentifier()
    self.comma = comma
    assert(comma.text == ",")
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }


  func buildImplementsAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> ImplementsAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeImplementsAttributeArguments(
      type: type.buildSimpleTypeIdentifier(format: format, leadingTrivia: nil),
      comma: comma,
      declBaseName: declBaseName.buildSyntax(format: format, leadingTrivia: nil),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildImplementsAttributeArguments(format: format, leadingTrivia: leadingTrivia)
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
/// A piece of an Objective-C selector. Either consisiting of just anidentifier for a nullary selector, an identifier and a colon for alabeled argument or just a colon for an unlabeled argument
public struct ObjCSelectorPiece: SyntaxBuildable, ExpressibleAsObjCSelectorPiece {
  let name: TokenSyntax?
  let colon: TokenSyntax?

  /// Creates a `ObjCSelectorPiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    name: TokenSyntax? = nil,
    colon: TokenSyntax? = nil
  ) {
    self.name = name
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    name: String?,
    colon: TokenSyntax? = nil
  ) {
    self.init(
      name: name.map(TokenSyntax.identifier),
      colon: colon
    )
  }

  func buildObjCSelectorPiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjCSelectorPieceSyntax {
    let result = SyntaxFactory.makeObjCSelectorPiece(
      name: name,
      colon: colon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildObjCSelectorPiece(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DifferentiableAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - diffKind: 
  ///   - diffKindComma: The comma following the differentiability kind, if it exists.
  ///   - diffParams: 
  ///   - diffParamsComma: The comma following the differentiability parameters clause,if it exists.
  ///   - whereClause: 
  public init(
    diffKind: TokenSyntax? = nil,
    diffKindComma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
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
    diffKind: String?,
    diffKindComma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.init(
      diffKind: diffKind.map(TokenSyntax.identifier),
      diffKindComma: diffKindComma,
      diffParams: diffParams,
      diffParamsComma: diffParamsComma,
      whereClause: whereClause
    )
  }

  func buildDifferentiableAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiableAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDifferentiableAttributeArguments(
      diffKind: diffKind,
      diffKindComma: diffKindComma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil),
      diffParamsComma: diffParamsComma,
      whereClause: whereClause?.buildGenericWhereClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiableAttributeArguments(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DifferentiabilityParamsClause` using the provided parameters.
  /// - Parameters:
  ///   - wrtLabel: The "wrt" label.
  ///   - colon: The colon separating "wrt" and the parameter list.
  ///   - parameters: 
  public init(
    wrtLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
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
    wrtLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      wrtLabel: TokenSyntax.identifier(wrtLabel),
      colon: colon,
      parameters: parameters
    )
  }

  func buildDifferentiabilityParamsClause(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsClauseSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParamsClause(
      wrtLabel: wrtLabel,
      colon: colon,
      parameters: parameters.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParamsClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DifferentiabilityParams` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - diffParams: The parameters for differentiation.
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    diffParams: ExpressibleAsDifferentiabilityParamList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.diffParams = diffParams.createDifferentiabilityParamList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @DifferentiabilityParamListBuilder diffParamsBuilder: () -> ExpressibleAsDifferentiabilityParamList = { DifferentiabilityParamList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      diffParams: diffParamsBuilder(),
      rightParen: rightParen
    )
  }

  func buildDifferentiabilityParams(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParams(
      leftParen: leftParen,
      diffParams: diffParams.buildDifferentiabilityParamList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParams(format: format, leadingTrivia: leadingTrivia)
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
public struct DifferentiabilityParam: SyntaxBuildable, ExpressibleAsDifferentiabilityParam {
  let parameter: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `DifferentiabilityParam` using the provided parameters.
  /// - Parameters:
  ///   - parameter: 
  ///   - trailingComma: 
  public init(
    parameter: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.parameter = parameter.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildDifferentiabilityParam(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParam(
      parameter: parameter.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDifferentiabilityParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsDifferentiabilityParam`.
  public func createDifferentiabilityParam() -> DifferentiabilityParam {
    return self
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
    ofLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: TokenSyntax? = nil,
    comma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
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
    ofLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: String?,
    comma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.init(
      ofLabel: TokenSyntax.identifier(ofLabel),
      colon: colon,
      originalDeclName: originalDeclName,
      period: period,
      accessorKind: accessorKind.map(TokenSyntax.identifier),
      comma: comma,
      diffParams: diffParams
    )
  }

  func buildDerivativeRegistrationAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let result = SyntaxFactory.makeDerivativeRegistrationAttributeArguments(
      ofLabel: ofLabel,
      colon: colon,
      originalDeclName: originalDeclName.buildQualifiedDeclName(format: format, leadingTrivia: nil),
      period: period,
      accessorKind: accessorKind,
      comma: comma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildDerivativeRegistrationAttributeArguments(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `QualifiedDeclName` using the provided parameters.
  /// - Parameters:
  ///   - baseType: The base type of the qualified name, optionally specified.
  ///   - dot: 
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    baseType: ExpressibleAsTypeBuildable? = nil,
    dot: TokenSyntax? = nil,
    name: TokenSyntax,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.baseType = baseType?.createTypeBuildable()
    self.dot = dot
    assert(dot == nil || dot!.text == "." || dot!.text == ".")
    self.name = name
    self.arguments = arguments?.createDeclNameArguments()
  }


  func buildQualifiedDeclName(format: Format, leadingTrivia: Trivia? = nil) -> QualifiedDeclNameSyntax {
    let result = SyntaxFactory.makeQualifiedDeclName(
      baseType: baseType?.buildType(format: format, leadingTrivia: nil),
      dot: dot,
      name: name,
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildQualifiedDeclName(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `FunctionDeclName` using the provided parameters.
  /// - Parameters:
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    name: ExpressibleAsSyntaxBuildable,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.name = name.createSyntaxBuildable()
    self.arguments = arguments?.createDeclNameArguments()
  }


  func buildFunctionDeclName(format: Format, leadingTrivia: Trivia? = nil) -> FunctionDeclNameSyntax {
    let result = SyntaxFactory.makeFunctionDeclName(
      name: name.buildSyntax(format: format, leadingTrivia: nil),
      arguments: arguments?.buildDeclNameArguments(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildFunctionDeclName(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `BackDeployAttributeSpecList` using the provided parameters.
  /// - Parameters:
  ///   - beforeLabel: The "before" label.
  ///   - colon: The colon separating "before" and the parameter list.
  ///   - versionList: The list of OS versions in which the declaration became ABIstable.
  public init(
    beforeLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    versionList: ExpressibleAsBackDeployVersionList
  ) {
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
    beforeLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @BackDeployVersionListBuilder versionListBuilder: () -> ExpressibleAsBackDeployVersionList = { BackDeployVersionList([]) }
  ) {
    self.init(
      beforeLabel: TokenSyntax.identifier(beforeLabel),
      colon: colon,
      versionList: versionListBuilder()
    )
  }

  func buildBackDeployAttributeSpecList(format: Format, leadingTrivia: Trivia? = nil) -> BackDeployAttributeSpecListSyntax {
    let result = SyntaxFactory.makeBackDeployAttributeSpecList(
      beforeLabel: beforeLabel,
      colon: colon,
      versionList: versionList.buildBackDeployVersionList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildBackDeployAttributeSpecList(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `BackDeployVersionArgument` using the provided parameters.
  /// - Parameters:
  ///   - availabilityVersionRestriction: 
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    availabilityVersionRestriction: ExpressibleAsAvailabilityVersionRestriction,
    trailingComma: TokenSyntax? = nil
  ) {
    self.availabilityVersionRestriction = availabilityVersionRestriction.createAvailabilityVersionRestriction()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildBackDeployVersionArgument(format: Format, leadingTrivia: Trivia? = nil) -> BackDeployVersionArgumentSyntax {
    let result = SyntaxFactory.makeBackDeployVersionArgument(
      availabilityVersionRestriction: availabilityVersionRestriction.buildAvailabilityVersionRestriction(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildBackDeployVersionArgument(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ContinueStmt` using the provided parameters.
  /// - Parameters:
  ///   - continueKeyword: 
  ///   - label: 
  public init(
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: TokenSyntax? = nil
  ) {
    self.continueKeyword = continueKeyword
    assert(continueKeyword.text == "continue")
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: String?
  ) {
    self.init(
      continueKeyword: continueKeyword,
      label: label.map(TokenSyntax.identifier)
    )
  }

  func buildContinueStmt(format: Format, leadingTrivia: Trivia? = nil) -> ContinueStmtSyntax {
    let result = SyntaxFactory.makeContinueStmt(
      continueKeyword: continueKeyword,
      label: label
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildContinueStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `WhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - whileKeyword: 
  ///   - conditions: 
  ///   - body: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    body: ExpressibleAsCodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleAsConditionElementList = { ConditionElementList([]) }
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditionsBuilder(),
      body: body
    )
  }

  func buildWhileStmt(format: Format, leadingTrivia: Trivia? = nil) -> WhileStmtSyntax {
    let result = SyntaxFactory.makeWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildWhileStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeferStmt` using the provided parameters.
  /// - Parameters:
  ///   - deferKeyword: 
  ///   - body: 
  public init(
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    body: ExpressibleAsCodeBlock
  ) {
    self.deferKeyword = deferKeyword
    assert(deferKeyword.text == "defer")
    self.body = body.createCodeBlock()
  }


  func buildDeferStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeferStmtSyntax {
    let result = SyntaxFactory.makeDeferStmt(
      deferKeyword: deferKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDeferStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ExpressionStmt` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    expression: ExpressibleAsExprBuildable
  ) {
    self.expression = expression.createExprBuildable()
  }


  func buildExpressionStmt(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionStmtSyntax {
    let result = SyntaxFactory.makeExpressionStmt(
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildExpressionStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `RepeatWhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - repeatKeyword: 
  ///   - body: 
  ///   - whileKeyword: 
  ///   - condition: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleAsCodeBlock,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleAsCodeBlock,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: body,
      whileKeyword: whileKeyword,
      condition: condition
    )
  }

  func buildRepeatWhileStmt(format: Format, leadingTrivia: Trivia? = nil) -> RepeatWhileStmtSyntax {
    let result = SyntaxFactory.makeRepeatWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      whileKeyword: whileKeyword,
      condition: condition.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildRepeatWhileStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `GuardStmt` using the provided parameters.
  /// - Parameters:
  ///   - guardKeyword: 
  ///   - conditions: 
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    conditions: ExpressibleAsConditionElementList,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
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
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleAsConditionElementList = { ConditionElementList([]) }
  ) {
    self.init(
      guardKeyword: guardKeyword,
      conditions: conditionsBuilder(),
      elseKeyword: elseKeyword,
      body: body
    )
  }

  func buildGuardStmt(format: Format, leadingTrivia: Trivia? = nil) -> GuardStmtSyntax {
    let result = SyntaxFactory.makeGuardStmt(
      guardKeyword: guardKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildGuardStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `WhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - guardResult: 
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    guardResult: ExpressibleAsExprBuildable
  ) {
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.guardResult = guardResult.createExprBuildable()
  }


  func buildWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> WhereClauseSyntax {
    let result = SyntaxFactory.makeWhereClause(
      whereKeyword: whereKeyword,
      guardResult: guardResult.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildWhereClause(format: format, leadingTrivia: leadingTrivia)
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
    body: ExpressibleAsCodeBlock
  ) {
    self.init(
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
      body: body
    )
  }

  func buildForInStmt(format: Format, leadingTrivia: Trivia? = nil) -> ForInStmtSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildForInStmt(format: format, leadingTrivia: leadingTrivia)
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
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    cases: ExpressibleAsSwitchCaseList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> ExpressibleAsSwitchCaseList = { SwitchCaseList([]) }
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression,
      leftBrace: leftBrace,
      cases: casesBuilder(),
      rightBrace: rightBrace
    )
  }

  func buildSwitchStmt(format: Format, leadingTrivia: Trivia? = nil) -> SwitchStmtSyntax {
    let result = SyntaxFactory.makeSwitchStmt(
      labelName: labelName,
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil),
      leftBrace: leftBrace,
      cases: cases.buildSwitchCaseList(format: format, leadingTrivia: nil),
      rightBrace: rightBrace
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildSwitchStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DoStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - doKeyword: 
  ///   - body: 
  ///   - catchClauses: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    body: ExpressibleAsCodeBlock,
    catchClauses: ExpressibleAsCatchClauseList? = nil
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    body: ExpressibleAsCodeBlock,
    @CatchClauseListBuilder catchClausesBuilder: () -> ExpressibleAsCatchClauseList? = { nil }
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: body,
      catchClauses: catchClausesBuilder()
    )
  }

  func buildDoStmt(format: Format, leadingTrivia: Trivia? = nil) -> DoStmtSyntax {
    let result = SyntaxFactory.makeDoStmt(
      labelName: labelName,
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      catchClauses: catchClauses?.buildCatchClauseList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDoStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ReturnStmt` using the provided parameters.
  /// - Parameters:
  ///   - returnKeyword: 
  ///   - expression: 
  public init(
    returnKeyword: TokenSyntax = TokenSyntax.`return`,
    expression: ExpressibleAsExprBuildable? = nil
  ) {
    self.returnKeyword = returnKeyword
    assert(returnKeyword.text == "return")
    self.expression = expression?.createExprBuildable()
  }


  func buildReturnStmt(format: Format, leadingTrivia: Trivia? = nil) -> ReturnStmtSyntax {
    let result = SyntaxFactory.makeReturnStmt(
      returnKeyword: returnKeyword,
      expression: expression?.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildReturnStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `YieldStmt` using the provided parameters.
  /// - Parameters:
  ///   - yieldKeyword: 
  ///   - yields: 
  public init(
    yieldKeyword: TokenSyntax = TokenSyntax.`yield`,
    yields: ExpressibleAsSyntaxBuildable
  ) {
    self.yieldKeyword = yieldKeyword
    assert(yieldKeyword.text == "yield")
    self.yields = yields.createSyntaxBuildable()
  }


  func buildYieldStmt(format: Format, leadingTrivia: Trivia? = nil) -> YieldStmtSyntax {
    let result = SyntaxFactory.makeYieldStmt(
      yieldKeyword: yieldKeyword,
      yields: yields.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildYieldStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `YieldList` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - trailingComma: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsExprList,
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elementList = elementList.createExprList()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @ExprListBuilder elementListBuilder: () -> ExpressibleAsExprList = { ExprList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      elementList: elementListBuilder(),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
  }

  func buildYieldList(format: Format, leadingTrivia: Trivia? = nil) -> YieldListSyntax {
    let result = SyntaxFactory.makeYieldList(
      leftParen: leftParen,
      elementList: elementList.buildExprList(format: format, leadingTrivia: nil),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildYieldList(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `FallthroughStmt` using the provided parameters.
  /// - Parameters:
  ///   - fallthroughKeyword: 
  public init(
    fallthroughKeyword: TokenSyntax = TokenSyntax.`fallthrough`
  ) {
    self.fallthroughKeyword = fallthroughKeyword
    assert(fallthroughKeyword.text == "fallthrough")
  }


  func buildFallthroughStmt(format: Format, leadingTrivia: Trivia? = nil) -> FallthroughStmtSyntax {
    let result = SyntaxFactory.makeFallthroughStmt(
      fallthroughKeyword: fallthroughKeyword
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildFallthroughStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `BreakStmt` using the provided parameters.
  /// - Parameters:
  ///   - breakKeyword: 
  ///   - label: 
  public init(
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: TokenSyntax? = nil
  ) {
    self.breakKeyword = breakKeyword
    assert(breakKeyword.text == "break")
    self.label = label
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: String?
  ) {
    self.init(
      breakKeyword: breakKeyword,
      label: label.map(TokenSyntax.identifier)
    )
  }

  func buildBreakStmt(format: Format, leadingTrivia: Trivia? = nil) -> BreakStmtSyntax {
    let result = SyntaxFactory.makeBreakStmt(
      breakKeyword: breakKeyword,
      label: label
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildBreakStmt(format: format, leadingTrivia: leadingTrivia)
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
public struct ConditionElement: SyntaxBuildable, ExpressibleAsConditionElement {
  let condition: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `ConditionElement` using the provided parameters.
  /// - Parameters:
  ///   - condition: 
  ///   - trailingComma: 
  public init(
    condition: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.condition = condition.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildConditionElement(format: Format, leadingTrivia: Trivia? = nil) -> ConditionElementSyntax {
    let result = SyntaxFactory.makeConditionElement(
      condition: condition.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildConditionElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsConditionElement`.
  public func createConditionElement() -> ConditionElement {
    return self
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

  /// Creates a `AvailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundAvailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundAvailableKeyword = poundAvailableKeyword
    assert(poundAvailableKeyword.text == "#available")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> ExpressibleAsAvailabilitySpecList = { AvailabilitySpecList([]) }
  ) {
    self.init(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpecBuilder(),
      rightParen: rightParen
    )
  }

  func buildAvailabilityCondition(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityConditionSyntax {
    let result = SyntaxFactory.makeAvailabilityCondition(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityCondition(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MatchingPatternCondition` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause
  ) {
    self.caseKeyword = caseKeyword
    assert(caseKeyword.text == "case")
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer.createInitializerClause()
  }


  func buildMatchingPatternCondition(format: Format, leadingTrivia: Trivia? = nil) -> MatchingPatternConditionSyntax {
    let result = SyntaxFactory.makeMatchingPatternCondition(
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildMatchingPatternCondition(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OptionalBindingCondition` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    letOrVarKeyword: TokenSyntax,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
  }


  func buildOptionalBindingCondition(format: Format, leadingTrivia: Trivia? = nil) -> OptionalBindingConditionSyntax {
    let result = SyntaxFactory.makeOptionalBindingCondition(
      letOrVarKeyword: letOrVarKeyword,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil),
      initializer: initializer?.buildInitializerClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildOptionalBindingCondition(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `UnavailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundUnavailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundUnavailableKeyword = poundUnavailableKeyword
    assert(poundUnavailableKeyword.text == "#unavailable")
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> ExpressibleAsAvailabilitySpecList = { AvailabilitySpecList([]) }
  ) {
    self.init(
      poundUnavailableKeyword: poundUnavailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpecBuilder(),
      rightParen: rightParen
    )
  }

  func buildUnavailabilityCondition(format: Format, leadingTrivia: Trivia? = nil) -> UnavailabilityConditionSyntax {
    let result = SyntaxFactory.makeUnavailabilityCondition(
      poundUnavailableKeyword: poundUnavailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildUnavailabilityCondition(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DeclarationStmt` using the provided parameters.
  /// - Parameters:
  ///   - declaration: 
  public init(
    declaration: ExpressibleAsDeclBuildable
  ) {
    self.declaration = declaration.createDeclBuildable()
  }


  func buildDeclarationStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeclarationStmtSyntax {
    let result = SyntaxFactory.makeDeclarationStmt(
      declaration: declaration.buildDecl(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildDeclarationStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ThrowStmt` using the provided parameters.
  /// - Parameters:
  ///   - throwKeyword: 
  ///   - expression: 
  public init(
    throwKeyword: TokenSyntax = TokenSyntax.`throw`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.throwKeyword = throwKeyword
    assert(throwKeyword.text == "throw")
    self.expression = expression.createExprBuildable()
  }


  func buildThrowStmt(format: Format, leadingTrivia: Trivia? = nil) -> ThrowStmtSyntax {
    let result = SyntaxFactory.makeThrowStmt(
      throwKeyword: throwKeyword,
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildThrowStmt(format: format, leadingTrivia: leadingTrivia)
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
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    body: ExpressibleAsCodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleAsConditionElementList = { ConditionElementList([]) }
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditionsBuilder(),
      body: body,
      elseKeyword: elseKeyword,
      elseBody: elseBody
    )
  }

  func buildIfStmt(format: Format, leadingTrivia: Trivia? = nil) -> IfStmtSyntax {
    let result = SyntaxFactory.makeIfStmt(
      labelName: labelName,
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditions.buildConditionElementList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil),
      elseKeyword: elseKeyword,
      elseBody: elseBody?.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildIfStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ElseIfContinuation` using the provided parameters.
  /// - Parameters:
  ///   - ifStatement: 
  public init(
    ifStatement: ExpressibleAsIfStmt
  ) {
    self.ifStatement = ifStatement.createIfStmt()
  }


  func buildElseIfContinuation(format: Format, leadingTrivia: Trivia? = nil) -> ElseIfContinuationSyntax {
    let result = SyntaxFactory.makeElseIfContinuation(
      ifStatement: ifStatement.buildIfStmt(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildElseIfContinuation(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ElseBlock` using the provided parameters.
  /// - Parameters:
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
    self.elseKeyword = elseKeyword
    assert(elseKeyword.text == "else")
    self.body = body.createCodeBlock()
  }


  func buildElseBlock(format: Format, leadingTrivia: Trivia? = nil) -> ElseBlockSyntax {
    let result = SyntaxFactory.makeElseBlock(
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildElseBlock(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SwitchCase` using the provided parameters.
  /// - Parameters:
  ///   - unknownAttr: 
  ///   - label: 
  ///   - statements: 
  public init(
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
    statements: ExpressibleAsCodeBlockItemList
  ) {
    self.unknownAttr = unknownAttr?.createAttribute()
    self.label = label.createSyntaxBuildable()
    self.statements = statements.createCodeBlockItemList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList = { CodeBlockItemList([]) }
  ) {
    self.init(
      unknownAttr: unknownAttr,
      label: label,
      statements: statementsBuilder()
    )
  }

  func buildSwitchCase(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseSyntax {
    let result = SyntaxFactory.makeSwitchCase(
      unknownAttr: unknownAttr?.buildAttribute(format: format, leadingTrivia: nil),
      label: label.buildSyntax(format: format, leadingTrivia: nil),
      statements: statements.buildCodeBlockItemList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchCase(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SwitchDefaultLabel` using the provided parameters.
  /// - Parameters:
  ///   - defaultKeyword: 
  ///   - colon: 
  public init(
    defaultKeyword: TokenSyntax = TokenSyntax.`default`,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.defaultKeyword = defaultKeyword
    assert(defaultKeyword.text == "default")
    self.colon = colon
    assert(colon.text == ":")
  }


  func buildSwitchDefaultLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchDefaultLabelSyntax {
    let result = SyntaxFactory.makeSwitchDefaultLabel(
      defaultKeyword: defaultKeyword,
      colon: colon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchDefaultLabel(format: format, leadingTrivia: leadingTrivia)
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
public struct CaseItem: SyntaxBuildable, ExpressibleAsCaseItem {
  let pattern: PatternBuildable
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// Creates a `CaseItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildCaseItem(format: Format, leadingTrivia: Trivia? = nil) -> CaseItemSyntax {
    let result = SyntaxFactory.makeCaseItem(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCaseItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCaseItem`.
  public func createCaseItem() -> CaseItem {
    return self
  }

  /// `CaseItem` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct CatchItem: SyntaxBuildable, ExpressibleAsCatchItem {
  let pattern: PatternBuildable?
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// Creates a `CatchItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern?.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildCatchItem(format: Format, leadingTrivia: Trivia? = nil) -> CatchItemSyntax {
    let result = SyntaxFactory.makeCatchItem(
      pattern: pattern?.buildPattern(format: format, leadingTrivia: nil),
      whereClause: whereClause?.buildWhereClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCatchItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsCatchItem`.
  public func createCatchItem() -> CatchItem {
    return self
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

  /// Creates a `SwitchCaseLabel` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - caseItems: 
  ///   - colon: 
  public init(
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    caseItems: ExpressibleAsCaseItemList,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
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
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @CaseItemListBuilder caseItemsBuilder: () -> ExpressibleAsCaseItemList = { CaseItemList([]) }
  ) {
    self.init(
      caseKeyword: caseKeyword,
      caseItems: caseItemsBuilder(),
      colon: colon
    )
  }

  func buildSwitchCaseLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseLabelSyntax {
    let result = SyntaxFactory.makeSwitchCaseLabel(
      caseKeyword: caseKeyword,
      caseItems: caseItems.buildCaseItemList(format: format, leadingTrivia: nil),
      colon: colon
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSwitchCaseLabel(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `CatchClause` using the provided parameters.
  /// - Parameters:
  ///   - catchKeyword: 
  ///   - catchItems: 
  ///   - body: 
  public init(
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    catchItems: ExpressibleAsCatchItemList? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.catchKeyword = catchKeyword
    assert(catchKeyword.text == "catch")
    self.catchItems = catchItems?.createCatchItemList()
    self.body = body.createCodeBlock()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    body: ExpressibleAsCodeBlock,
    @CatchItemListBuilder catchItemsBuilder: () -> ExpressibleAsCatchItemList? = { nil }
  ) {
    self.init(
      catchKeyword: catchKeyword,
      catchItems: catchItemsBuilder(),
      body: body
    )
  }

  func buildCatchClause(format: Format, leadingTrivia: Trivia? = nil) -> CatchClauseSyntax {
    let result = SyntaxFactory.makeCatchClause(
      catchKeyword: catchKeyword,
      catchItems: catchItems?.buildCatchItemList(format: format, leadingTrivia: nil),
      body: body.buildCodeBlock(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCatchClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PoundAssertStmt` using the provided parameters.
  /// - Parameters:
  ///   - poundAssert: 
  ///   - leftParen: 
  ///   - condition: The assertion condition.
  ///   - comma: The comma after the assertion condition.
  ///   - message: The assertion message.
  ///   - rightParen: 
  public init(
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
    comma: TokenSyntax? = nil,
    message: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
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

  func buildPoundAssertStmt(format: Format, leadingTrivia: Trivia? = nil) -> PoundAssertStmtSyntax {
    let result = SyntaxFactory.makePoundAssertStmt(
      poundAssert: poundAssert,
      leftParen: leftParen,
      condition: condition.buildExpr(format: format, leadingTrivia: nil),
      comma: comma,
      message: message,
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `StmtBuildable`.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let result = buildPoundAssertStmt(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `GenericWhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - requirementList: 
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    requirementList: ExpressibleAsGenericRequirementList
  ) {
    self.whereKeyword = whereKeyword
    assert(whereKeyword.text == "where")
    self.requirementList = requirementList.createGenericRequirementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    @GenericRequirementListBuilder requirementListBuilder: () -> ExpressibleAsGenericRequirementList = { GenericRequirementList([]) }
  ) {
    self.init(
      whereKeyword: whereKeyword,
      requirementList: requirementListBuilder()
    )
  }

  func buildGenericWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericWhereClauseSyntax {
    let result = SyntaxFactory.makeGenericWhereClause(
      whereKeyword: whereKeyword,
      requirementList: requirementList.buildGenericRequirementList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericWhereClause(format: format, leadingTrivia: leadingTrivia)
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
public struct GenericRequirement: SyntaxBuildable, ExpressibleAsGenericRequirement {
  let body: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `GenericRequirement` using the provided parameters.
  /// - Parameters:
  ///   - body: 
  ///   - trailingComma: 
  public init(
    body: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.body = body.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildGenericRequirement(format: Format, leadingTrivia: Trivia? = nil) -> GenericRequirementSyntax {
    let result = SyntaxFactory.makeGenericRequirement(
      body: body.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericRequirement`.
  public func createGenericRequirement() -> GenericRequirement {
    return self
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

  /// Creates a `SameTypeRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - equalityToken: 
  ///   - rightTypeIdentifier: 
  public init(
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    equalityToken: TokenSyntax,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.equalityToken = equalityToken
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  func buildSameTypeRequirement(format: Format, leadingTrivia: Trivia? = nil) -> SameTypeRequirementSyntax {
    let result = SyntaxFactory.makeSameTypeRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      equalityToken: equalityToken,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildSameTypeRequirement(format: format, leadingTrivia: leadingTrivia)
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
public struct GenericParameter: SyntaxBuildable, ExpressibleAsGenericParameter {
  let attributes: AttributeList?
  let name: TokenSyntax
  let colon: TokenSyntax?
  let inheritedType: TypeBuildable?
  let trailingComma: TokenSyntax?

  /// Creates a `GenericParameter` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - name: 
  ///   - colon: 
  ///   - inheritedType: 
  ///   - trailingComma: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    name: TokenSyntax,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
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
    name: String,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      name: TokenSyntax.identifier(name),
      colon: colon,
      inheritedType: inheritedType,
      trailingComma: trailingComma
    )
  }

  func buildGenericParameter(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterSyntax {
    let result = SyntaxFactory.makeGenericParameter(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      name: name,
      colon: colon,
      inheritedType: inheritedType?.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericParameter`.
  public func createGenericParameter() -> GenericParameter {
    return self
  }

  /// `GenericParameter` might conform to `ExpressibleAsSyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }

}
public struct PrimaryAssociatedType: SyntaxBuildable, ExpressibleAsPrimaryAssociatedType {
  let attributes: AttributeList?
  let name: TokenSyntax
  let colon: TokenSyntax?
  let inheritedType: TypeBuildable?
  let initializer: TypeInitializerClause?
  let trailingComma: TokenSyntax?

  /// Creates a `PrimaryAssociatedType` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - name: 
  ///   - colon: 
  ///   - inheritedType: 
  ///   - initializer: 
  ///   - trailingComma: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    name: TokenSyntax,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.name = name
    self.colon = colon
    assert(colon == nil || colon!.text == ":")
    self.inheritedType = inheritedType?.createTypeBuildable()
    self.initializer = initializer?.createTypeInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    name: String,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      name: TokenSyntax.identifier(name),
      colon: colon,
      inheritedType: inheritedType,
      initializer: initializer,
      trailingComma: trailingComma
    )
  }

  func buildPrimaryAssociatedType(format: Format, leadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedType(
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      name: name,
      colon: colon,
      inheritedType: inheritedType?.buildType(format: format, leadingTrivia: nil),
      initializer: initializer?.buildTypeInitializerClause(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrimaryAssociatedType(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsPrimaryAssociatedType`.
  public func createPrimaryAssociatedType() -> PrimaryAssociatedType {
    return self
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

  /// Creates a `GenericParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - genericParameterList: 
  ///   - rightAngleBracket: 
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    genericParameterList: ExpressibleAsGenericParameterList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
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
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> ExpressibleAsGenericParameterList = { GenericParameterList([]) }
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterListBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }

  func buildGenericParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterClauseSyntax {
    let result = SyntaxFactory.makeGenericParameterClause(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterList.buildGenericParameterList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericParameterClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ConformanceRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - colon: 
  ///   - rightTypeIdentifier: 
  public init(
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }


  func buildConformanceRequirement(format: Format, leadingTrivia: Trivia? = nil) -> ConformanceRequirementSyntax {
    let result = SyntaxFactory.makeConformanceRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format, leadingTrivia: nil),
      colon: colon,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildConformanceRequirement(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `PrimaryAssociatedTypeClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - primaryAssociatedTypeList: 
  ///   - rightAngleBracket: 
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    primaryAssociatedTypeList: ExpressibleAsPrimaryAssociatedTypeList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leftAngleBracket = leftAngleBracket
    assert(leftAngleBracket.text == "<")
    self.primaryAssociatedTypeList = primaryAssociatedTypeList.createPrimaryAssociatedTypeList()
    self.rightAngleBracket = rightAngleBracket
    assert(rightAngleBracket.text == ">")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @PrimaryAssociatedTypeListBuilder primaryAssociatedTypeListBuilder: () -> ExpressibleAsPrimaryAssociatedTypeList = { PrimaryAssociatedTypeList([]) }
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      primaryAssociatedTypeList: primaryAssociatedTypeListBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }

  func buildPrimaryAssociatedTypeClause(format: Format, leadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeClauseSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedTypeClause(
      leftAngleBracket: leftAngleBracket,
      primaryAssociatedTypeList: primaryAssociatedTypeList.buildPrimaryAssociatedTypeList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildPrimaryAssociatedTypeClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `SimpleTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.name = name
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  func buildSimpleTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> SimpleTypeIdentifierSyntax {
    let result = SyntaxFactory.makeSimpleTypeIdentifier(
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildSimpleTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MemberTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax,
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.baseType = baseType.createTypeBuildable()
    self.period = period
    assert(period.text == "." || period.text == ".")
    self.name = name
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }


  func buildMemberTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> MemberTypeIdentifierSyntax {
    let result = SyntaxFactory.makeMemberTypeIdentifier(
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      period: period,
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildMemberTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ClassRestrictionType` using the provided parameters.
  /// - Parameters:
  ///   - classKeyword: 
  public init(
    classKeyword: TokenSyntax = TokenSyntax.`class`
  ) {
    self.classKeyword = classKeyword
    assert(classKeyword.text == "class")
  }


  func buildClassRestrictionType(format: Format, leadingTrivia: Trivia? = nil) -> ClassRestrictionTypeSyntax {
    let result = SyntaxFactory.makeClassRestrictionType(
      classKeyword: classKeyword
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildClassRestrictionType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ArrayType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - elementType: 
  ///   - rightSquareBracket: 
  public init(
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elementType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.elementType = elementType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  func buildArrayType(format: Format, leadingTrivia: Trivia? = nil) -> ArrayTypeSyntax {
    let result = SyntaxFactory.makeArrayType(
      leftSquareBracket: leftSquareBracket,
      elementType: elementType.buildType(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildArrayType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `DictionaryType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - keyType: 
  ///   - colon: 
  ///   - valueType: 
  ///   - rightSquareBracket: 
  public init(
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    keyType: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket
    assert(leftSquareBracket.text == "[")
    self.keyType = keyType.createTypeBuildable()
    self.colon = colon
    assert(colon.text == ":")
    self.valueType = valueType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(rightSquareBracket.text == "]")
  }


  func buildDictionaryType(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryTypeSyntax {
    let result = SyntaxFactory.makeDictionaryType(
      leftSquareBracket: leftSquareBracket,
      keyType: keyType.buildType(format: format, leadingTrivia: nil),
      colon: colon,
      valueType: valueType.buildType(format: format, leadingTrivia: nil),
      rightSquareBracket: rightSquareBracket
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildDictionaryType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `MetatypeType` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - typeOrProtocol: 
  public init(
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: TokenSyntax
  ) {
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
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: String
  ) {
    self.init(
      baseType: baseType,
      period: period,
      typeOrProtocol: TokenSyntax.identifier(typeOrProtocol)
    )
  }

  func buildMetatypeType(format: Format, leadingTrivia: Trivia? = nil) -> MetatypeTypeSyntax {
    let result = SyntaxFactory.makeMetatypeType(
      baseType: baseType.buildType(format: format, leadingTrivia: nil),
      period: period,
      typeOrProtocol: typeOrProtocol
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildMetatypeType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - questionMark: 
  public init(
    wrappedType: ExpressibleAsTypeBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  func buildOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> OptionalTypeSyntax {
    let result = SyntaxFactory.makeOptionalType(
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildOptionalType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ConstrainedSugarType` using the provided parameters.
  /// - Parameters:
  ///   - someOrAnySpecifier: 
  ///   - baseType: 
  public init(
    someOrAnySpecifier: TokenSyntax,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.someOrAnySpecifier = someOrAnySpecifier
    assert(someOrAnySpecifier.text == "some" || someOrAnySpecifier.text == "any")
    self.baseType = baseType.createTypeBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    someOrAnySpecifier: String,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.init(
      someOrAnySpecifier: TokenSyntax.identifier(someOrAnySpecifier),
      baseType: baseType
    )
  }

  func buildConstrainedSugarType(format: Format, leadingTrivia: Trivia? = nil) -> ConstrainedSugarTypeSyntax {
    let result = SyntaxFactory.makeConstrainedSugarType(
      someOrAnySpecifier: someOrAnySpecifier,
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildConstrainedSugarType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ImplicitlyUnwrappedOptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - exclamationMark: 
  public init(
    wrappedType: ExpressibleAsTypeBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.exclamationMark = exclamationMark
    assert(exclamationMark.text == "!")
  }


  func buildImplicitlyUnwrappedOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let result = SyntaxFactory.makeImplicitlyUnwrappedOptionalType(
      wrappedType: wrappedType.buildType(format: format, leadingTrivia: nil),
      exclamationMark: exclamationMark
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildImplicitlyUnwrappedOptionalType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `CompositionTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - ampersand: 
  public init(
    type: ExpressibleAsTypeBuildable,
    ampersand: TokenSyntax? = nil
  ) {
    self.type = type.createTypeBuildable()
    self.ampersand = ampersand
    assert(ampersand == nil || ampersand!.text == "&")
  }


  func buildCompositionTypeElement(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeElementSyntax {
    let result = SyntaxFactory.makeCompositionTypeElement(
      type: type.buildType(format: format, leadingTrivia: nil),
      ampersand: ampersand
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildCompositionTypeElement(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `CompositionType` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    elements: ExpressibleAsCompositionTypeElementList
  ) {
    self.elements = elements.createCompositionTypeElementList()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    @CompositionTypeElementListBuilder elementsBuilder: () -> ExpressibleAsCompositionTypeElementList = { CompositionTypeElementList([]) }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }

  func buildCompositionType(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeSyntax {
    let result = SyntaxFactory.makeCompositionType(
      elements: elements.buildCompositionTypeElementList(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildCompositionType(format: format, leadingTrivia: leadingTrivia)
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
public struct TupleTypeElement: SyntaxBuildable, ExpressibleAsTupleTypeElement {
  let inOut: TokenSyntax?
  let name: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable
  let ellipsis: TokenSyntax?
  let initializer: InitializerClause?
  let trailingComma: TokenSyntax?

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
    inOut: TokenSyntax? = nil,
    name: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable,
    ellipsis: TokenSyntax? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
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


  func buildTupleTypeElement(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeElementSyntax {
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
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTupleTypeElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTupleTypeElement`.
  public func createTupleTypeElement() -> TupleTypeElement {
    return self
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

  /// Creates a `TupleType` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(leftParen.text == "(")
    self.elements = elements.createTupleTypeElementList()
    self.rightParen = rightParen
    assert(rightParen.text == ")")
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleTypeElementListBuilder elementsBuilder: () -> ExpressibleAsTupleTypeElementList = { TupleTypeElementList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }

  func buildTupleType(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeSyntax {
    let result = SyntaxFactory.makeTupleType(
      leftParen: leftParen,
      elements: elements.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildTupleType(format: format, leadingTrivia: leadingTrivia)
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
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

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable,
    @TupleTypeElementListBuilder argumentsBuilder: () -> ExpressibleAsTupleTypeElementList = { TupleTypeElementList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen,
      asyncKeyword: asyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      arrow: arrow,
      returnType: returnType
    )
  }

  func buildFunctionType(format: Format, leadingTrivia: Trivia? = nil) -> FunctionTypeSyntax {
    let result = SyntaxFactory.makeFunctionType(
      leftParen: leftParen,
      arguments: arguments.buildTupleTypeElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen,
      asyncKeyword: asyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      arrow: arrow,
      returnType: returnType.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildFunctionType(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AttributedType` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - attributes: 
  ///   - baseType: 
  public init(
    specifier: TokenSyntax? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.specifier = specifier
    assert(specifier == nil || specifier!.text == "inout" || specifier!.text == "__shared" || specifier!.text == "__owned")
    self.attributes = attributes?.createAttributeList()
    self.baseType = baseType.createTypeBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    specifier: TokenSyntax? = nil,
    baseType: ExpressibleAsTypeBuildable,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleAsAttributeList? = { nil }
  ) {
    self.init(
      specifier: specifier,
      attributes: attributesBuilder(),
      baseType: baseType
    )
  }

  func buildAttributedType(format: Format, leadingTrivia: Trivia? = nil) -> AttributedTypeSyntax {
    let result = SyntaxFactory.makeAttributedType(
      specifier: specifier,
      attributes: attributes?.buildAttributeList(format: format, leadingTrivia: nil),
      baseType: baseType.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `TypeBuildable`.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let result = buildAttributedType(format: format, leadingTrivia: leadingTrivia)
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
public struct GenericArgument: SyntaxBuildable, ExpressibleAsGenericArgument {
  let argumentType: TypeBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `GenericArgument` using the provided parameters.
  /// - Parameters:
  ///   - argumentType: 
  ///   - trailingComma: 
  public init(
    argumentType: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.argumentType = argumentType.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildGenericArgument(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentSyntax {
    let result = SyntaxFactory.makeGenericArgument(
      argumentType: argumentType.buildType(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsGenericArgument`.
  public func createGenericArgument() -> GenericArgument {
    return self
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

  /// Creates a `GenericArgumentClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - arguments: 
  ///   - rightAngleBracket: 
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    arguments: ExpressibleAsGenericArgumentList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
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
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> ExpressibleAsGenericArgumentList = { GenericArgumentList([]) }
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      arguments: argumentsBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }

  func buildGenericArgumentClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentClauseSyntax {
    let result = SyntaxFactory.makeGenericArgumentClause(
      leftAngleBracket: leftAngleBracket,
      arguments: arguments.buildGenericArgumentList(format: format, leadingTrivia: nil),
      rightAngleBracket: rightAngleBracket
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildGenericArgumentClause(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TypeAnnotation` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - type: 
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.colon = colon
    assert(colon.text == ":")
    self.type = type.createTypeBuildable()
  }


  func buildTypeAnnotation(format: Format, leadingTrivia: Trivia? = nil) -> TypeAnnotationSyntax {
    let result = SyntaxFactory.makeTypeAnnotation(
      colon: colon,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTypeAnnotation(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `EnumCasePattern` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - period: 
  ///   - caseName: 
  ///   - associatedTuple: 
  public init(
    type: ExpressibleAsTypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: TokenSyntax,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
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
    type: ExpressibleAsTypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: String,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.init(
      type: type,
      period: period,
      caseName: TokenSyntax.identifier(caseName),
      associatedTuple: associatedTuple
    )
  }

  func buildEnumCasePattern(format: Format, leadingTrivia: Trivia? = nil) -> EnumCasePatternSyntax {
    let result = SyntaxFactory.makeEnumCasePattern(
      type: type?.buildType(format: format, leadingTrivia: nil),
      period: period,
      caseName: caseName,
      associatedTuple: associatedTuple?.buildTuplePattern(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildEnumCasePattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - isKeyword: 
  ///   - type: 
  public init(
    isKeyword: TokenSyntax = TokenSyntax.`is`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.isKeyword = isKeyword
    assert(isKeyword.text == "is")
    self.type = type.createTypeBuildable()
  }


  func buildIsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> IsTypePatternSyntax {
    let result = SyntaxFactory.makeIsTypePattern(
      isKeyword: isKeyword,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildIsTypePattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `OptionalPattern` using the provided parameters.
  /// - Parameters:
  ///   - subPattern: 
  ///   - questionMark: 
  public init(
    subPattern: ExpressibleAsPatternBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.subPattern = subPattern.createPatternBuildable()
    self.questionMark = questionMark
    assert(questionMark.text == "?")
  }


  func buildOptionalPattern(format: Format, leadingTrivia: Trivia? = nil) -> OptionalPatternSyntax {
    let result = SyntaxFactory.makeOptionalPattern(
      subPattern: subPattern.buildPattern(format: format, leadingTrivia: nil),
      questionMark: questionMark
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildOptionalPattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `IdentifierPattern` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  public init(
    identifier: TokenSyntax
  ) {
    self.identifier = identifier
  }


  func buildIdentifierPattern(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierPatternSyntax {
    let result = SyntaxFactory.makeIdentifierPattern(
      identifier: identifier
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildIdentifierPattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - asKeyword: 
  ///   - type: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    asKeyword: TokenSyntax = TokenSyntax.`as`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.asKeyword = asKeyword
    assert(asKeyword.text == "as")
    self.type = type.createTypeBuildable()
  }


  func buildAsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> AsTypePatternSyntax {
    let result = SyntaxFactory.makeAsTypePattern(
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      asKeyword: asKeyword,
      type: type.buildType(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildAsTypePattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `TuplePattern` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTuplePatternElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> ExpressibleAsTuplePatternElementList = { TuplePatternElementList([]) }
  ) {
    self.init(
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }

  func buildTuplePattern(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternSyntax {
    let result = SyntaxFactory.makeTuplePattern(
      leftParen: leftParen,
      elements: elements.buildTuplePatternElementList(format: format, leadingTrivia: nil),
      rightParen: rightParen
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildTuplePattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `WildcardPattern` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  ///   - typeAnnotation: 
  public init(
    wildcard: TokenSyntax = TokenSyntax.`wildcard`,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil
  ) {
    self.wildcard = wildcard
    assert(wildcard.text == "_")
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
  }


  func buildWildcardPattern(format: Format, leadingTrivia: Trivia? = nil) -> WildcardPatternSyntax {
    let result = SyntaxFactory.makeWildcardPattern(
      wildcard: wildcard,
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildWildcardPattern(format: format, leadingTrivia: leadingTrivia)
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
public struct TuplePatternElement: SyntaxBuildable, ExpressibleAsTuplePatternElement {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let pattern: PatternBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `TuplePatternElement` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - pattern: 
  ///   - trailingComma: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
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
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      labelName: labelName.map(TokenSyntax.identifier),
      labelColon: labelColon,
      pattern: pattern,
      trailingComma: trailingComma
    )
  }

  func buildTuplePatternElement(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternElementSyntax {
    let result = SyntaxFactory.makeTuplePatternElement(
      labelName: labelName,
      labelColon: labelColon,
      pattern: pattern.buildPattern(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildTuplePatternElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(result)
  }

  /// Conformance to `ExpressibleAsTuplePatternElement`.
  public func createTuplePatternElement() -> TuplePatternElement {
    return self
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

  /// Creates a `ExpressionPattern` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    expression: ExpressibleAsExprBuildable
  ) {
    self.expression = expression.createExprBuildable()
  }


  func buildExpressionPattern(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionPatternSyntax {
    let result = SyntaxFactory.makeExpressionPattern(
      expression: expression.buildExpr(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildExpressionPattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `ValueBindingPattern` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - valuePattern: 
  public init(
    letOrVarKeyword: TokenSyntax,
    valuePattern: ExpressibleAsPatternBuildable
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    assert(letOrVarKeyword.text == "let" || letOrVarKeyword.text == "var")
    self.valuePattern = valuePattern.createPatternBuildable()
  }


  func buildValueBindingPattern(format: Format, leadingTrivia: Trivia? = nil) -> ValueBindingPatternSyntax {
    let result = SyntaxFactory.makeValueBindingPattern(
      letOrVarKeyword: letOrVarKeyword,
      valuePattern: valuePattern.buildPattern(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `PatternBuildable`.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let result = buildValueBindingPattern(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AvailabilityArgument` using the provided parameters.
  /// - Parameters:
  ///   - entry: The actual argument
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    entry: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.entry = entry.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || trailingComma!.text == ",")
  }


  func buildAvailabilityArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityArgument(
      entry: entry.buildSyntax(format: format, leadingTrivia: nil),
      trailingComma: trailingComma
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityArgument(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AvailabilityLabeledArgument` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating label and value
  ///   - value: The value of this labeled argument
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.label = label
    self.colon = colon
    assert(colon.text == ":")
    self.value = value.createSyntaxBuildable()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.init(
      label: TokenSyntax.identifier(label),
      colon: colon,
      value: value
    )
  }

  func buildAvailabilityLabeledArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityLabeledArgumentSyntax {
    let result = SyntaxFactory.makeAvailabilityLabeledArgument(
      label: label,
      colon: colon,
      value: value.buildSyntax(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityLabeledArgument(format: format, leadingTrivia: leadingTrivia)
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

  /// Creates a `AvailabilityVersionRestriction` using the provided parameters.
  /// - Parameters:
  ///   - platform: The name of the OS on which the availability should berestricted or 'swift' if the availability should berestricted based on a Swift version.
  ///   - version: 
  public init(
    platform: TokenSyntax,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.platform = platform
    self.version = version?.createVersionTuple()
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    platform: String,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.init(
      platform: TokenSyntax.identifier(platform),
      version: version
    )
  }

  func buildAvailabilityVersionRestriction(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityVersionRestrictionSyntax {
    let result = SyntaxFactory.makeAvailabilityVersionRestriction(
      platform: platform,
      version: version?.buildVersionTuple(format: format, leadingTrivia: nil)
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildAvailabilityVersionRestriction(format: format, leadingTrivia: leadingTrivia)
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
/// A version number of the form major.minor.patch in which the minorand patch part may be ommited.
public struct VersionTuple: SyntaxBuildable, ExpressibleAsVersionTuple {
  let majorMinor: SyntaxBuildable
  let patchPeriod: TokenSyntax?
  let patchVersion: TokenSyntax?

  /// Creates a `VersionTuple` using the provided parameters.
  /// - Parameters:
  ///   - majorMinor: In case the version consists only of the major version, aninteger literal that specifies the major version. In casethe version consists of major and minor version number, afloating literal in which the decimal part is interpretedas the minor version.
  ///   - patchPeriod: If the version contains a patch number, the periodseparating the minor from the patch number.
  ///   - patchVersion: The patch version if specified.
  public init(
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: TokenSyntax? = nil
  ) {
    self.majorMinor = majorMinor.createSyntaxBuildable()
    self.patchPeriod = patchPeriod
    assert(patchPeriod == nil || patchPeriod!.text == ".")
    self.patchVersion = patchVersion
  }

  /// A convenience initializer that allows:
  ///  - Initializing syntax collections using result builders
  ///  - Initializing tokens without default text using strings
  public init(
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: String?
  ) {
    self.init(
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }

  func buildVersionTuple(format: Format, leadingTrivia: Trivia? = nil) -> VersionTupleSyntax {
    let result = SyntaxFactory.makeVersionTuple(
      majorMinor: majorMinor.buildSyntax(format: format, leadingTrivia: nil),
      patchPeriod: patchPeriod,
      patchVersion: patchVersion
    )
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  /// Conformance to `SyntaxBuildable`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let result = buildVersionTuple(format: format, leadingTrivia: leadingTrivia)
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
