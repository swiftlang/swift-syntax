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
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

/// Removes redundant parentheses from expressions.
///
/// Examples:
/// - `((x))` -> `x`
/// - `(x)` -> `x` (where x is a simple expression)
///
public struct RemoveRedundantParentheses: SyntaxRefactoringProvider {
  public static func refactor(
    syntax: TupleExprSyntax,
    in context: Void
  ) -> ExprSyntax {
    // If the tuple has any unexpected nodes, it's not a simple parenthetical expression
    // we should be refactoring (e.g., parsing recovery might have put some parts in unexpected nodes).
    guard syntax.unexpectedBeforeLeftParen == nil,
      syntax.unexpectedBetweenLeftParenAndElements == nil,
      syntax.unexpectedBetweenElementsAndRightParen == nil,
      syntax.unexpectedAfterRightParen == nil
    else {
      return ExprSyntax(syntax)
    }

    // Check if the tuple expression has exactly one element and no label.
    guard let innerExpr = syntax.elements.singleUnlabeledExpression else {
      return ExprSyntax(syntax)
    }

    // Case 1: Nested parentheses ((expression)) -> (expression)
    // Recursively strip inner parentheses to handle cases like (((x))) -> x
    if let innerTuple = innerExpr.as(TupleExprSyntax.self) {
      return preserveTrivia(from: syntax, to: refactor(syntax: innerTuple, in: ()))
    }

    // Case 2: Parentheses around simple expressions
    if canRemoveParentheses(around: innerExpr, in: syntax.parent) {
      return preserveTrivia(from: syntax, to: innerExpr)
    }

    // Default: Return unchanged
    return ExprSyntax(syntax)
  }

  private static func preserveTrivia(from outer: TupleExprSyntax, to inner: ExprSyntax) -> ExprSyntax {
    let leadingTrivia = outer.leftParen.leadingTrivia
      .merging(outer.leftParen.trailingTrivia)
      .merging(inner.leadingTrivia)
    let trailingTrivia = inner.trailingTrivia
      .merging(outer.rightParen.leadingTrivia)
      .merging(outer.rightParen.trailingTrivia)
    return
      inner
      .with(\.leadingTrivia, leadingTrivia)
      .with(\.trailingTrivia, trailingTrivia)
  }

  private static func canRemoveParentheses(around expr: ExprSyntax, in parent: Syntax?) -> Bool {
    // Safety Check: Ambiguous Closures
    // Closures and trailing closures inside conditions need parentheses to avoid ambiguity.
    // e.g. `if ({ true }) == ({ true }) {}` or `if (call { true }) == false {}`
    // This applies to if/while/guard (ConditionElementSyntax) and repeat-while (RepeatStmtSyntax).
    // It also applies to InitializerClauseSyntax if it is inside a condition (e.g. `if let x = ({...})`).
    let isInCondition =
      parent?.ancestorOrSelf(mapping: {
        if $0.is(ConditionElementSyntax.self) || $0.is(RepeatStmtSyntax.self) {
          return $0
        }
        return nil
      }) != nil

    if isInCondition && (expr.is(ClosureExprSyntax.self) || hasTrailingClosure(expr)) {
      return false
    }

    // Safety Check: Immediately-invoked closures
    if let functionCall = parent?.as(FunctionCallExprSyntax.self),
      functionCall.calledExpression.as(TupleExprSyntax.self) != nil,
      expr.is(ClosureExprSyntax.self)
    {
      return false
    }

    // Allowlist: Parents where parentheses are always redundant (unless blocked above)
    if let parent = parent,
      parent.is(InitializerClauseSyntax.self)
        || parent.is(ConditionElementSyntax.self)
        || parent.is(ReturnStmtSyntax.self)
        || parent.is(ThrowStmtSyntax.self)
        || parent.is(SwitchExprSyntax.self)
        || parent.is(RepeatStmtSyntax.self)
    {
      return true
    }

    // Fallback: Allow if the expression itself is "simple"
    guard isSimpleExpression(expr) else {
      return false
    }

    // Safety Check: Postfix Precedence
    // Expressions like `try`, `await`, `consume`, and `copy` bind looser than postfix expressions.
    // e.g., `(try? f()).description` is different from `try? f().description`.
    // The former accesses `.description` on the Optional result, the latter on the unwrapped value.
    if isPostfixParent(parent) {
      switch expr.as(ExprSyntaxEnum.self) {
      case .tryExpr, .awaitExpr, .unsafeExpr, .consumeExpr, .copyExpr:
        return false
      default:
        break
      }
    }

    return true
  }

  /// Returns true if parent is a postfix expression where the tuple is the base.
  private static func isPostfixParent(_ parent: Syntax?) -> Bool {
    switch parent?.as(SyntaxEnum.self) {
    case .memberAccessExpr(let memberAccess):
      return memberAccess.base != nil
    case .subscriptCallExpr(let subscriptCall):
      return subscriptCall.calledExpression.is(TupleExprSyntax.self)
    case .functionCallExpr(let functionCall):
      return functionCall.calledExpression.is(TupleExprSyntax.self)
    case .postfixOperatorExpr:
      return true
    default:
      return false
    }
  }

  private static func hasTrailingClosure(_ expr: ExprSyntax) -> Bool {
    switch expr.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let functionCall):
      return functionCall.trailingClosure != nil || !functionCall.additionalTrailingClosures.isEmpty
    case .macroExpansionExpr(let macroExpansion):
      return macroExpansion.trailingClosure != nil || !macroExpansion.additionalTrailingClosures.isEmpty
    case .subscriptCallExpr(let subscriptCall):
      return subscriptCall.trailingClosure != nil || !subscriptCall.additionalTrailingClosures.isEmpty
    default:
      return false
    }
  }

  /// Checks if a type is simple enough to not require parentheses.
  /// Complex types like `any Equatable`, `some P`, or `A & B` need parentheses, e.g. `(any Equatable).self`.
  private static func isSimpleType(_ type: TypeSyntax) -> Bool {
    switch type.as(TypeSyntaxEnum.self) {
    case .arrayType,
      .classRestrictionType,
      .dictionaryType,
      .identifierType,
      .implicitlyUnwrappedOptionalType,
      .inlineArrayType,
      .memberType,
      .metatypeType,
      .missingType,
      .optionalType,
      .tupleType:
      return true
    case .attributedType,  // @escaping, @Sendable, etc.
      .compositionType,  // A & B
      .functionType,  // (A) -> B
      .namedOpaqueReturnType,
      .packElementType,
      .packExpansionType,
      .someOrAnyType,  // some P, any P
      .suppressedType:  // ~Copyable
      return false
    }
  }

  private static func isSimpleExpression(_ expr: ExprSyntax) -> Bool {
    // Allow-list of simple expressions that typically don't depend on precedence
    // in a way that requires parentheses when used in most contexts,
    // or are self-contained.
    switch expr.as(ExprSyntaxEnum.self) {
    case .arrayExpr,
      .booleanLiteralExpr,
      .closureExpr,
      .declReferenceExpr,
      .dictionaryExpr,
      .floatLiteralExpr,
      .forceUnwrapExpr,
      .integerLiteralExpr,
      .macroExpansionExpr,
      .memberAccessExpr,
      .nilLiteralExpr,
      .optionalChainingExpr,
      .regexLiteralExpr,
      .simpleStringLiteralExpr,
      .stringLiteralExpr,
      .subscriptCallExpr,
      .superExpr:
      return true
    case .typeExpr(let typeExpr):
      // Types like `any Equatable` need parentheses, e.g. `(any Equatable).self`
      return isSimpleType(typeExpr.type)
    case .awaitExpr(let awaitExpr):
      // await is only simple if its expression is also simple
      return isSimpleExpression(awaitExpr.expression)
    case .unsafeExpr(let unsafeExpr):
      // Similar to await, unsafe is only simple if its expression is simple
      return isSimpleExpression(unsafeExpr.expression)
    case .tryExpr(let tryExpr):
      // Only try! and try? are simple; regular try is NOT simple
      // because it affects precedence (e.g., try (try! foo()).bar() vs try try! foo().bar())
      guard tryExpr.questionOrExclamationMark != nil else {
        return false
      }
      return isSimpleExpression(tryExpr.expression)
    case .functionCallExpr(let functionCall):
      // A function call is simple enough to remove parentheses around it.
      // Immediately-invoked closures need parentheses for disambiguation.
      // Without parentheses, `let x = { 1 }()` parses as `let x = { 1 }` followed by `()` as a separate
      // statement, rather than calling the closure. With parentheses: `let x = ({ 1 })()` works correctly.
      return !functionCall.calledExpression.is(ClosureExprSyntax.self)
    default:
      return false
    }
  }
}
