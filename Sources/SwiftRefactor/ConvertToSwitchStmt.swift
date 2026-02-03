//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntax
public import SwiftSyntaxBuilder
#else
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

/// Converts an `if ... else if ... else` chain into a `switch` statement
/// when all conditions compare the same subject against values using `==`.
///
/// ## Before
///
/// ```swift
/// if a == 1 {
///   print("one")
/// } else if a == 2 {
///   print("two")
/// } else {
///   print("other")
/// }
/// ```
///
/// ## After
///
/// ```swift
/// switch a {
/// case 1:
///   print("one")
/// case 2:
///   print("two")
/// default:
///   print("other")
/// }
/// ```
public struct ConvertToSwitchStmt: SyntaxRefactoringProvider {
  public static func refactor(syntax ifExpr: IfExprSyntax, in context: Void) throws -> SwitchExprSyntax {
    
    // 1. Identify Subject and Pattern from the first `if`.
    guard let (subject, firstPattern) = extractSubjectAndPattern(from: ifExpr) else {
      throw RefactoringNotApplicableError("First condition invalid")
    }
    
    var cases: [SwitchCaseSyntax] = []
    
    // Add first case
    cases.append(createCase(pattern: firstPattern, body: ifExpr.body))
    
    // 2. Iterate through `else if` and `else` blocks.
    var currentIf = ifExpr
    
    while let elseBody = currentIf.elseBody {
      switch elseBody {
      case .ifExpr(let nextIf):
        // Else If block
        // Must match subject and operator
        guard let (nextSubject, nextPattern) = extractSubjectAndPattern(from: nextIf) else {
           throw RefactoringNotApplicableError("Subsequent condition invalid")
        }
        
        // Ensure subject is structurally identical (ignoring trivia)
        // We use trimmedDescription for comparison.
        guard nextSubject.trimmedDescription == subject.trimmedDescription else {
           throw RefactoringNotApplicableError("Subject mismatch")
        }
        
        cases.append(createCase(pattern: nextPattern, body: nextIf.body))
        currentIf = nextIf
        
      case .codeBlock(let defaultBlock):
        // Else block -> Default case
        cases.append(createDefaultCase(body: defaultBlock))
        // Valid termination
        let caseList = SwitchCaseListSyntax(cases.map(SwitchCaseListSyntax.Element.init))
        return SwitchExprSyntax(
          switchKeyword: .keyword(.switch, trailingTrivia: .space),
          subject: subject.trimmed,
          leftBrace: .leftBraceToken(leadingTrivia: .space),
          cases: caseList,
          rightBrace: .rightBraceToken(leadingTrivia: .newlines(1))
        )
      }
    }
    
    // If we exit loop without hitting a .codeBlock (else), strict switch requires checking exhaustiveness.
    // However, for a refactoring, replacing `if` with `switch` without default is valid 
    // IF the type is exhaustive (e.g. enum) OR we accept non-exhaustive switch?
    // But `if` is not exhaustive.
    // `switch` MUST be exhaustive.
    // So if there is NO `else` block, we *cannot* safely convert to switch 
    // unless we know it's exhaustive, which we don't (semantic info needed).
    // EXCEPT: if we insert a `default: break`?
    // Issue description doesn't specify. Safe refactoring usually implies semantic equivalence.
    // `if a == 1 {}` is valid. `switch a { case 1: ... }` is INVALID (Switch must be exhaustive).
    // Therefore, if there is no `else`, we MUST likely abort OR add `default: break`.
    // Adding `default: break` is safe.
    
    if ifExpr.elseBody == nil || cases.last?.label.is(SwitchDefaultLabelSyntax.self) == false {
        // Add default: break
        let breakStmt = CodeBlockItemSyntax(
          leadingTrivia: .newlines(1) + .spaces(2), 
          item: .stmt(StmtSyntax(BreakStmtSyntax()))
        )
        cases.append(createDefaultCase(body: CodeBlockSyntax(statements: [breakStmt])))
    }
    
    let caseList = SwitchCaseListSyntax(cases.map(SwitchCaseListSyntax.Element.init))
    return SwitchExprSyntax(
      switchKeyword: .keyword(.switch, trailingTrivia: .space),
      subject: subject.trimmed,
      leftBrace: .leftBraceToken(leadingTrivia: .space),
      cases: caseList,
      rightBrace: .rightBraceToken(leadingTrivia: .newlines(1))
    )
  }
  
  // MARK: - Helpers
  
  private static func extractSubjectAndPattern(from ifExpr: IfExprSyntax) -> (ExprSyntax, ExprSyntax)? {
    // strict: single condition
    guard ifExpr.conditions.count == 1,
          let condition = ifExpr.conditions.first,
          case .expression(let expr) = condition.condition
    else {
      return nil
    }
    
    // Handle both SequenceExpr (unfolded) and InfixOperatorExpr (folded)
    if let seq = expr.as(SequenceExprSyntax.self) {
      // Expect [LHS, ==, RHS]
      guard seq.elements.count == 3 else { return nil }
      let lhs = seq.elements.first!
      let op = seq.elements[seq.elements.index(after: seq.elements.startIndex)]
      let rhs = seq.elements.last!
      
      guard let opExpr = op.as(BinaryOperatorExprSyntax.self), opExpr.operator.text == "==" else {
        return nil
      }
      return (lhs, rhs)
    }
    
    if let infix = expr.as(InfixOperatorExprSyntax.self) {
      guard let opExpr = infix.operator.as(BinaryOperatorExprSyntax.self), opExpr.operator.text == "==" else {
        return nil
      }
      return (infix.leftOperand, infix.rightOperand)
    }
    
    return nil
  }
  
  private static func createCase(pattern: ExprSyntax, body: CodeBlockSyntax) -> SwitchCaseSyntax {
    // Pattern must be `ExpressionPattern` for switch case
    // `case value:`
    let caseItem = SwitchCaseItemSyntax(pattern: ExpressionPatternSyntax(expression: pattern.trimmed))
    return SwitchCaseSyntax(
      leadingTrivia: .newlines(1),
      label: .case(SwitchCaseLabelSyntax(caseKeyword: .keyword(.case, trailingTrivia: .space), caseItems: [caseItem])),
      statements: body.statements
    )
  }
  
  private static func createDefaultCase(body: CodeBlockSyntax) -> SwitchCaseSyntax {
    return SwitchCaseSyntax(
      leadingTrivia: .newlines(1),
      label: .default(SwitchDefaultLabelSyntax()),
      statements: body.statements
    )
  }
}
