//===--- ParseDiagnosticsGenerator.swift ----------------------------------===//
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

import SwiftDiagnostics
@_spi(RawSyntax) import SwiftSyntax

extension UnexpectedNodesSyntax {
  func tokens(satisfying isIncluded: (TokenSyntax) -> Bool) -> [TokenSyntax] {
    return self.children(viewMode: .sourceAccurate).compactMap({ $0.as(TokenSyntax.self) }).filter(isIncluded)
  }

  func tokens(withKind kind: TokenKind) -> [TokenSyntax] {
    return self.tokens(satisfying: { $0.tokenKind == kind })
  }
}

fileprivate extension FixIt.Change {
  /// Replaced a present node with a missing node
  static func makeMissing(node: TokenSyntax) -> FixIt.Change {
    assert(node.presence == .present)
    return .replace(
      oldNode: Syntax(node),
      newNode: Syntax(TokenSyntax(node.tokenKind, leadingTrivia: [], trailingTrivia: [], presence: .missing))
    )
  }

  static func makePresent<T: SyntaxProtocol>(node: T) -> FixIt.Change {
    return .replace(
      oldNode: Syntax(node),
      newNode: PresentMaker().visit(Syntax(node))
    )
  }
}

fileprivate extension FixIt {
  init(message: StaticParserFixIt, changes: [Change]) {
    self.init(message: message as FixItMessage, changes: changes)
  }
}

public class ParseDiagnosticsGenerator: SyntaxAnyVisitor {
  private var diagnostics: [Diagnostic] = []

  /// IDs of nodes for which we already generated diagnostics in a parent's visit
  /// method and that should thus not be visited.
  private var handledNodes: [SyntaxIdentifier] = []

  private init() {
    super.init(viewMode: .all)
  }

  public static func diagnostics<SyntaxType: SyntaxProtocol>(
    for tree: SyntaxType
  ) -> [Diagnostic] {
    let diagProducer = ParseDiagnosticsGenerator()
    diagProducer.walk(tree)
    diagProducer.diagnostics.sort {
      return $0.node.id.indexInTree < $1.node.id.indexInTree
    }
    return diagProducer.diagnostics
  }

  // MARK: - Private helper functions

  /// Produce a diagnostic.
  private func addDiagnostic<T: SyntaxProtocol>(_ node: T, _ message: DiagnosticMessage, highlights: [Syntax] = [], fixIts: [FixIt] = []) {
    diagnostics.append(Diagnostic(node: Syntax(node), message: message, highlights: highlights, fixIts: fixIts))
  }

  /// Produce a diagnostic.
  private func addDiagnostic<T: SyntaxProtocol>(_ node: T, _ message: StaticParserError, highlights: [Syntax] = [], fixIts: [FixIt] = []) {
    addDiagnostic(node, message as DiagnosticMessage, highlights: highlights, fixIts: fixIts)
  }

  /// If a diagnostic is generated that covers multiple syntax nodes, mark them as handles so they don't produce the generic diagnostics anymore.
  private func markNodesAsHandled(_ nodes: SyntaxIdentifier...) {
    handledNodes.append(contentsOf: nodes)
  }

  /// Whether the node should be skipped for diagnostic emission.
  /// Every visit method must check this at the beginning.
  private func shouldSkip<T: SyntaxProtocol>(_ node: T) -> Bool {
    return handledNodes.contains(node.id)
  }

  // MARK: - Generic diagnostic generation

  public override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    return .visitChildren
  }

  override public func visit(_ node: UnexpectedNodesSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    addDiagnostic(node, UnexpectedNodesError(unexpectedNodes: node))
    return .skipChildren
  }

  override public func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.presence == .missing {
      addDiagnostic(node, MissingTokenError(missingToken: node), fixIts: [
        FixIt(message: InsertTokenFixIt(missingToken: node), changes: [
          .makePresent(node: node)
        ])
      ])
    }
    return .skipChildren
  }

  // MARK: - Specialized diagnostic generation

  public override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let argument = node.argument, argument.isMissingAllTokens {
      addDiagnostic(argument, MissingAttributeArgument(attributeName: node.attributeName), fixIts: [
        FixIt(message: .insertAttributeArguments, changes: [
          .makePresent(node: argument)
        ])
      ])
      markNodesAsHandled(argument.id)
      return .visitChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Detect C-style for loops based on two semicolons which could not be parsed between the 'for' keyword and the '{'
    // This is mostly a proof-of-concept implementation to produce more complex diagnostics.
    if let unexpectedCondition = node.body.unexpectedBeforeLeftBrace,
       unexpectedCondition.tokens(withKind: .semicolon).count == 2 {
      // FIXME: This is aweful. We should have a way to either get all children between two cursors in a syntax node or highlight a range from one node to another.
      addDiagnostic(node, .cStyleForLoop, highlights: ([
        Syntax(node.pattern),
        Syntax(node.unexpectedBetweenPatternAndTypeAnnotation),
        Syntax(node.typeAnnotation),
        Syntax(node.unexpectedBetweenTypeAnnotationAndInKeyword),
        Syntax(node.inKeyword),
        Syntax(node.unexpectedBetweenInKeywordAndSequenceExpr),
        Syntax(node.sequenceExpr),
        Syntax(node.unexpectedBetweenSequenceExprAndWhereClause),
        Syntax(node.whereClause),
        Syntax(node.unexpectedBetweenWhereClauseAndBody),
        Syntax(unexpectedCondition)
      ] as [Syntax?]).compactMap({ $0 }))
      markNodesAsHandled(node.inKeyword.id, unexpectedCondition.id)
    }
    return .visitChildren
  }

  public override func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let output = node.output,
       let missingThrowsKeyword = node.throwsOrRethrowsKeyword,
       missingThrowsKeyword.presence == .missing,
       let unexpectedBeforeReturnType = output.unexpectedBetweenArrowAndReturnType,
       let throwsInReturnPosition = unexpectedBeforeReturnType.tokens(withKind: .throwsKeyword).first {
      addDiagnostic(throwsInReturnPosition, .throwsInReturnPosition, fixIts: [
        FixIt(message: .moveThrowBeforeArrow, changes: [
          .makeMissing(node: throwsInReturnPosition),
          .makePresent(node: missingThrowsKeyword),
        ])
      ])
      markNodesAsHandled(unexpectedBeforeReturnType.id, missingThrowsKeyword.id, throwsInReturnPosition.id)
      return .visitChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.leftParen.presence == .missing && node.parameterList.isEmpty && node.rightParen.presence == .missing {
      addDiagnostic(node, .missingFunctionParameterClause)
      markNodesAsHandled(node.leftParen.id, node.parameterList.id, node.rightParen.id)
    }
    return .visitChildren
  }

  public override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let extraneous = node.unexpectedBetweenStatementsAndEOFToken, !extraneous.isEmpty {
      addDiagnostic(extraneous, ExtaneousCodeAtTopLevel(extraneousCode: extraneous))
      markNodesAsHandled(extraneous.id)
    }
    return .visitChildren
  }

  public override func visit(_ node: UnresolvedTernaryExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.colonMark.presence == .missing {
      addDiagnostic(node.colonMark, .missingColonInTernaryExprDiagnostic)
      markNodesAsHandled(node.colonMark.id)
    }
    return .visitChildren
  }
}

