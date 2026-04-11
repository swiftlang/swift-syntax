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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Converts an if-else statement that assigns to the same variable in both branches
/// into a ternary expression assignment.
///
/// ## Before
///
/// ```swift
/// let result: Type
/// if condition {
///   result = trueValue
/// } else {
///   result = falseValue
/// }
/// ```
///
/// ## After
///
/// ```swift
/// let result: Type = condition ? trueValue : falseValue
/// ```
///
/// Also supports:
/// - Tuple assignments: `(a, b) = condition ? (1, "a") : (2, "b")`
/// - Assignment without declaration: `existingVar = condition ? value1 : value2`
///
/// This refactoring is applicable when:
/// - There is an if-else statement (no else-if chains)
/// - Both branches contain a single assignment expression
/// - Both assignments target the same variable / same tuple pattern
/// - Optionally, the variable is declared immediately before the if statement
public struct ConvertToTernaryExpression: EditRefactoringProvider {
  public static func textRefactor(syntax: IfExprSyntax, in context: Void) throws -> [SourceEdit] {
    guard let convertible = try ConvertibleIfElse(ifExpr: syntax) else {
      throw RefactoringNotApplicableError(
        "Cannot convert: if-else branches must each contain a single assignment to the same variable"
      )
    }

    // Walk up to find the CodeBlockItemSyntax containing this if expression
    let ifItem: CodeBlockItemSyntax
    if let exprStmt = syntax.parent?.as(ExpressionStmtSyntax.self),
      let item = exprStmt.parent?.as(CodeBlockItemSyntax.self)
    {
      ifItem = item
    } else if let item = syntax.parent?.as(CodeBlockItemSyntax.self) {
      ifItem = item
    } else {
      throw RefactoringNotApplicableError("if expression is not in a code block")
    }

    guard let codeBlockList = ifItem.parent?.as(CodeBlockItemListSyntax.self) else {
      throw RefactoringNotApplicableError("if expression is not in a code block list")
    }

    // Check for a preceding compatible variable declaration
    let items = Array(codeBlockList)
    guard let ifIdx = items.firstIndex(where: { $0.id == ifItem.id }) else {
      throw RefactoringNotApplicableError("cannot find if expression in code block")
    }

    let precedingItem = ifIdx > 0 ? items[ifIdx - 1] : nil
    if let precedingItem,
      let varDecl = precedingItem.item.as(VariableDeclSyntax.self),
      varDecl.isVariableDeclarationWithoutInitializer,
      let binding = varDecl.bindings.only,
      let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self),
      identifierPattern.identifier.text == convertible.assignmentTargetName
    {
      // Case: merge preceding decl + if → single declaration with ternary initializer.
      // Replace the range from the start of the declaration to the end of the if expression
      // (excluding surrounding trivia), preserving whatever whitespace is on either side.
      let newDecl = createTernaryDeclaration(from: convertible, variableDecl: varDecl)
      let range = precedingItem.positionAfterSkippingLeadingTrivia..<ifItem.endPositionBeforeTrailingTrivia
      return [SourceEdit(range: range, replacement: newDecl.trimmed.description)]
    } else {
      // Case: standalone if → assignment expression with ternary.
      // Replace just the if expression's content, preserving surrounding trivia.
      let assignment = createTernaryAssignment(from: convertible)
      let assignmentStmt = ExpressionStmtSyntax(expression: assignment)
      let range = ifItem.positionAfterSkippingLeadingTrivia..<ifItem.endPositionBeforeTrailingTrivia
      return [SourceEdit(range: range, replacement: assignmentStmt.trimmed.description)]
    }
  }

  // MARK: - Extracting Assignments

  fileprivate static func extractSingleAssignment(
    from codeBlock: CodeBlockSyntax
  ) throws -> AssignmentInfo? {
    guard let statement = codeBlock.statements.only else {
      return nil
    }

    let expr: ExprSyntax
    if let exprStmt = statement.item.as(ExpressionStmtSyntax.self) {
      expr = exprStmt.expression
    } else if let directExpr = statement.item.as(ExprSyntax.self) {
      expr = directExpr
    } else {
      return nil
    }

    guard let sequenceExpr = expr.as(SequenceExprSyntax.self) else {
      return nil
    }

    return try extractFromSequenceAssignment(sequenceExpr)
  }

  private static func extractFromSequenceAssignment(
    _ sequenceExpr: SequenceExprSyntax
  ) throws -> AssignmentInfo? {
    let elements = Array(sequenceExpr.elements)

    guard elements.count >= 3, elements[1].as(AssignmentExprSyntax.self) != nil else {
      return nil
    }

    let lhs = ExprSyntax(elements[0])
    let rhs: ExprSyntax
    if elements.count == 3 {
      rhs = ExprSyntax(elements[2])
    } else {
      rhs = ExprSyntax(SequenceExprSyntax(elements: ExprListSyntax(Array(elements[2...]))))
    }

    return AssignmentInfo(
      targetExpr: lhs,
      targetName: lhs.as(DeclReferenceExprSyntax.self)?.baseName.text,
      valueExpr: rhs
    )
  }

  // MARK: - Builders

  private static func makeTernaryExpr(from convertible: ConvertibleIfElse) -> TernaryExprSyntax {
    TernaryExprSyntax(
      condition: convertible.condition.trimmed.with(\.trailingTrivia, .space),
      questionMark: .infixQuestionMarkToken(trailingTrivia: .space),
      thenExpression: convertible.trueExpr.trimmed.with(\.trailingTrivia, .space),
      colon: .colonToken(trailingTrivia: .space),
      elseExpression: convertible.falseExpr.trimmed
    )
  }

  /// Creates the new variable declaration with ternary initializer.
  /// Preserves the original type annotation for named tuples only.
  private static func createTernaryDeclaration(
    from convertible: ConvertibleIfElse,
    variableDecl: VariableDeclSyntax
  ) -> VariableDeclSyntax {
    guard let originalBinding = variableDecl.bindings.only else {
      fatalError("Invalid state: binding should exist")
    }

    let ternaryExpr = makeTernaryExpr(from: convertible)

    let preserveAnnotation = originalBinding.typeAnnotation.map { isNamedTupleType($0.type) } ?? false
    let typeAnnotation: TypeAnnotationSyntax? = preserveAnnotation ? originalBinding.typeAnnotation?.trimmed : nil

    let newBinding =
      originalBinding
      .with(\.typeAnnotation, typeAnnotation)
      .with(
        \.initializer,
        InitializerClauseSyntax(
          equal: .equalToken(leadingTrivia: .space, trailingTrivia: .space),
          value: ExprSyntax(ternaryExpr)
        )
      )

    return variableDecl.with(\.bindings, PatternBindingListSyntax([newBinding]))
  }

  /// Creates a ternary assignment expression (when no declaration exists).
  private static func createTernaryAssignment(from convertible: ConvertibleIfElse) -> ExprSyntax {
    let ternaryExpr = makeTernaryExpr(from: convertible)

    let assignmentSeq = SequenceExprSyntax(
      elements: ExprListSyntax([
        convertible.assignmentTargetExpr.with(\.trailingTrivia, .space),
        ExprSyntax(AssignmentExprSyntax()).with(\.trailingTrivia, .space),
        ExprSyntax(ternaryExpr),
      ])
    )

    return ExprSyntax(assignmentSeq)
  }

  // MARK: - Validation Helpers

  private static func isNamedTupleType(_ type: TypeSyntax) -> Bool {
    guard let tupleType = type.as(TupleTypeSyntax.self) else { return false }
    return tupleType.elements.contains { $0.firstName != nil }
  }
}

// MARK: - Models

/// Holds the extracted components of a convertible if-else pattern.
///
/// Example: given
/// ```swift
/// if condition {
///   result = trueValue
/// } else {
///   result = falseValue
/// }
/// ```
/// - `assignmentTargetExpr` is `result`
/// - `assignmentTargetName` is `"result"` (`nil` for tuple targets like `(x, y)`)
/// - `condition` is `condition`
/// - `trueExpr` is `trueValue` (from the then-branch)
/// - `falseExpr` is `falseValue` (from the else-branch)
private struct ConvertibleIfElse {
  /// LHS of the assignment (`result` or `(x, y)`).
  let assignmentTargetExpr: ExprSyntax

  /// Only present when LHS is a simple identifier (e.g. `result`).
  let assignmentTargetName: String?

  let condition: ExprSyntax
  let trueExpr: ExprSyntax
  let falseExpr: ExprSyntax

  init?(ifExpr: IfExprSyntax) throws {
    guard let conditionElement = ifExpr.conditions.only,
      case .expression(let condition) = conditionElement.condition
    else {
      return nil
    }

    guard let elseBody = ifExpr.elseBody, case .codeBlock(let elseBlock) = elseBody else {
      return nil
    }

    guard let thenAssignment = try ConvertToTernaryExpression.extractSingleAssignment(from: ifExpr.body) else {
      return nil
    }

    guard let elseAssignment = try ConvertToTernaryExpression.extractSingleAssignment(from: elseBlock) else {
      return nil
    }

    guard thenAssignment.targetExpr.trimmed.description == elseAssignment.targetExpr.trimmed.description else {
      return nil
    }

    self.assignmentTargetExpr = thenAssignment.targetExpr
    self.assignmentTargetName = thenAssignment.targetName
    self.condition = condition
    self.trueExpr = thenAssignment.valueExpr
    self.falseExpr = elseAssignment.valueExpr
  }
}

/// Represents the extracted components of a single assignment expression.
///
/// Example: for `result = trueValue`:
/// - `targetExpr` is `result`
/// - `targetName` is `"result"` (nil for tuple targets like `(x, y)`)
/// - `valueExpr` is `trueValue`
///
/// Example: for `(x, y) = (1, 2)`:
/// - `targetExpr` is `(x, y)`
/// - `targetName` is `nil`
/// - `valueExpr` is `(1, 2)`
private struct AssignmentInfo {
  let targetExpr: ExprSyntax
  let targetName: String?
  let valueExpr: ExprSyntax
}

extension VariableDeclSyntax {
  /// Returns `true` if this is a `let` or `var` declaration with a type annotation
  /// but no initializer and no attributes.
  ///
  /// Example: `let result: Int` → `true`; `let result = 0` → `false`
  fileprivate var isVariableDeclarationWithoutInitializer: Bool {
    guard let binding = bindings.only,
      binding.typeAnnotation?.type != nil,
      binding.initializer == nil,
      attributes.isEmpty
    else {
      return false
    }
    return true
  }
}
