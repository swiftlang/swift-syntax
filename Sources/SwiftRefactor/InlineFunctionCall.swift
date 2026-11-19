//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public struct InlineFunctionCall: SyntaxRefactoringProvider {

  public typealias Input = FunctionCallExprSyntax
  public typealias Output = Syntax
  public typealias Context = Void

  public static func refactor(syntax: FunctionCallExprSyntax, in context: Void) throws -> Syntax {

    guard let calledExpr = syntax.calledExpression.as(DeclReferenceExprSyntax.self) else {
      throw RefactoringNotApplicableError("cursor must be on a function call")
    }
    let funcName = calledExpr.baseName.text

    // Find declaration
    guard let root = syntax.root.as(SourceFileSyntax.self),
      let declaration = root.statements.compactMap({ $0.item.as(FunctionDeclSyntax.self) })
        .first(where: { $0.name.text == funcName })
    else {
      throw RefactoringNotApplicableError("could not find function definition")
    }

    // Extract body of function
    guard let body = declaration.body else {
      throw RefactoringNotApplicableError("function has no body to inline")
    }

    // Substitution logic
    var substitutionMap: [String: ExprSyntax] = [:]
    let parameters = declaration.signature.parameterClause.parameters
    let arguments = syntax.arguments

    for (param, arg) in zip(parameters, arguments) {
      let paramName = param.secondName?.text ?? param.firstName.text
      substitutionMap[paramName] = arg.expression
    }

    let rewriter = ParameterSubstitutionRewriter(map: substitutionMap)

    if body.statements.count == 1,
      let returnStmt = body.statements.first?.item.as(ReturnStmtSyntax.self),
      let expr = returnStmt.expression
    {

      let newExpr = rewriter.visit(expr)
      return Syntax(newExpr)
    }

    let newBody = rewriter.visit(body)

    let closure = ClosureExprSyntax {
      newBody.statements
    }

    let call = FunctionCallExprSyntax(
      calledExpression: ExprSyntax(closure),
      leftParen: .leftParenToken(),
      arguments: LabeledExprListSyntax([]),
      rightParen: .rightParenToken()
    )

    return Syntax(call)
  }
}

private class ParameterSubstitutionRewriter: SyntaxRewriter {
  let map: [String: ExprSyntax]
  init(map: [String: ExprSyntax]) { self.map = map }

  override func visit(_ node: DeclReferenceExprSyntax) -> ExprSyntax {
    if let replacement = map[node.baseName.text] {
      return
        replacement
        .with(\.leadingTrivia, node.leadingTrivia)
        .with(\.trailingTrivia, node.trailingTrivia)
    }
    return super.visit(node)
  }
}
