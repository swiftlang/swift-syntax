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
      if $0.position != $1.position {
        return $0.position < $1.position
      }

      // Emit children diagnostics before parent diagnostics.
      // This makes sure that for missing declarations with attributes, we emit diagnostics on the attribute before we complain about the missing declaration.
      if $0.node.hasParent($1.node) {
        return true
      } else if $1.node.hasParent($0.node) {
        return false
      } else {
        // If multiple tokens are missing at the same location, emit diagnostics about nodes that occur earlier in the tree first.
        return $0.node.id.indexInTree < $1.node.id.indexInTree
      }
    }
    return diagProducer.diagnostics
  }

  // MARK: - Private helper functions

  /// Produce a diagnostic.
  func addDiagnostic<T: SyntaxProtocol>(
    _ node: T,
    position: AbsolutePosition? = nil,
    _ message: DiagnosticMessage,
    highlights: [Syntax] = [],
    notes: [Note] = [],
    fixIts: [FixIt] = [],
    handledNodes: [SyntaxIdentifier] = []
  ) {
    diagnostics.removeAll(where: { handledNodes.contains($0.node.id) })
    diagnostics.append(Diagnostic(node: Syntax(node), position: position, message: message, highlights: highlights, notes: notes, fixIts: fixIts))
    self.handledNodes.append(contentsOf: handledNodes)
  }

  /// Produce a diagnostic.
  func addDiagnostic<T: SyntaxProtocol>(
    _ node: T,
    position: AbsolutePosition? = nil,
    _ message: StaticParserError,
    highlights: [Syntax] = [],
    notes: [Note] = [],
    fixIts: [FixIt] = [],
    handledNodes: [SyntaxIdentifier] = []
  ) {
    addDiagnostic(
      node,
      position: position,
      message as DiagnosticMessage,
      highlights: highlights,
      notes: notes,
      fixIts: fixIts,
      handledNodes: handledNodes
    )
  }

  /// Whether the node should be skipped for diagnostic emission.
  /// Every visit method must check this at the beginning.
  func shouldSkip<T: SyntaxProtocol>(_ node: T) -> Bool {
    if !node.hasError {
      return true
    }
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
      // If there is an unexpected token in front of the identifier, we assume
      // that this unexpected token was intended to be the identifier we are missing.
      if let invalidIdentifier = node.previousToken(viewMode: .all),
          let previousParent = invalidIdentifier.parent?.as(UnexpectedNodesSyntax.self) {
        addDiagnostic(invalidIdentifier, InvalidIdentifierError(invalidIdentifier: invalidIdentifier), handledNodes: [previousParent.id])
      } else {
        return handleMissingSyntax(node)
      }
    }
    return .skipChildren
  }

  // MARK: - Specialized diagnostic generation

  public override func visit(_ node: MissingDeclSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingExprSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingPatternSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingStmtSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingTypeSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let argument = node.argument, argument.isMissingAllTokens {
      addDiagnostic(argument, MissingAttributeArgument(attributeName: node.attributeName), fixIts: [
        FixIt(message: .insertAttributeArguments, changes: [
          .makePresent(node: argument)
        ])
      ], handledNodes: [argument.id])
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
      addDiagnostic(
        node,
        .cStyleForLoop,
        highlights: ([
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
        ] as [Syntax?]).compactMap({ $0 }),
        handledNodes: [node.inKeyword.id, node.sequenceExpr.id, unexpectedCondition.id]
      )
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
      ], handledNodes: [unexpectedBeforeReturnType.id, missingThrowsKeyword.id, throwsInReturnPosition.id])
      return .visitChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.leftParen.presence == .missing && node.parameterList.isEmpty && node.rightParen.presence == .missing {
      addDiagnostic(node, .missingFunctionParameterClause, handledNodes: [node.leftParen.id, node.parameterList.id, node.rightParen.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let extraneous = node.unexpectedBetweenStatementsAndEOFToken, !extraneous.isEmpty {
      addDiagnostic(extraneous, ExtaneousCodeAtTopLevel(extraneousCode: extraneous), handledNodes: [extraneous.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: UnresolvedTernaryExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.colonMark.presence == .missing {
      addDiagnostic(node.colonMark, .missingColonInTernaryExprDiagnostic, handledNodes: [node.colonMark.id])
    }
    return .visitChildren
  }
}

