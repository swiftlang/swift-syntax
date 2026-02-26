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
public struct ConvertToTernaryExpression: SyntaxRefactoringProvider {

  public static func refactor(syntax: CodeBlockItemListSyntax, in context: Void) throws -> CodeBlockItemListSyntax {
    guard let convertible = try findConvertiblePattern(in: syntax) else {
      throw RefactoringNotApplicableError(
        "Cannot convert: if-else branches must each contain a single assignment to the same variable"
      )
    }

    return performRefactoring(syntax: syntax, convertible: convertible)
  }

  // MARK: - Models
  /// ConvertibleIfElse
  private struct ConvertibleIfElse {
    let variableDecl: VariableDeclSyntax?
    let ifExpr: IfExprSyntax

    /// LHS of the assignment (`result` or `(x, y)`).
    let assignmentTargetExpr: ExprSyntax

    /// Only present when LHS is a simple identifier (e.g. `result`).
    let assignmentTargetName: String?

    let condition: ExprSyntax
    let trueExpr: ExprSyntax
    let falseExpr: ExprSyntax

    let variableDeclIndex: Int?
    let ifExprIndex: Int
    let isTupleAssignment: Bool
  }

  /// AssignmentInfo
  private struct AssignmentInfo {
    let targetExpr: ExprSyntax
    let targetName: String?
    let valueExpr: ExprSyntax
    let isTuple: Bool
  }

  // MARK: - Finding Patterns
  /// Finds a convertible if-else pattern by searching for if expressions first,
  /// then optionally checking for a preceding variable declaration.
  private static func findConvertiblePattern(in codeBlock: CodeBlockItemListSyntax) throws -> ConvertibleIfElse? {
    let items = Array(codeBlock)
    guard !items.isEmpty else { return nil }

    for (ifIndex, item) in items.enumerated() {
      guard let ifExpr = extractIfExpr(from: item) else { continue }

      var varDecl: VariableDeclSyntax? = nil
      var varIndex: Int? = nil

      if ifIndex > 0,
        let previousVarDecl = items[ifIndex - 1].item.as(VariableDeclSyntax.self),
        declarationMatchesIfAssignment(previousVarDecl, ifExpr: ifExpr)
      {
        varDecl = previousVarDecl
        varIndex = ifIndex - 1
      }

      if let convertible = try analyzePattern(
        variableDecl: varDecl,
        ifExpr: ifExpr,
        varIndex: varIndex,
        ifIndex: ifIndex
      ) {
        return convertible
      }
    }

    return nil
  }

  private static func extractIfExpr(from item: CodeBlockItemSyntax) -> IfExprSyntax? {
    if let exprStmt = item.item.as(ExpressionStmtSyntax.self) {
      return exprStmt.expression.as(IfExprSyntax.self)
    }
    return item.item.as(IfExprSyntax.self)
  }

  /// Quick check to see if a variable declaration matches the assignment in an if expression
  private static func declarationMatchesIfAssignment(
    _ varDecl: VariableDeclSyntax,
    ifExpr: IfExprSyntax
  ) -> Bool {
    guard validateVariableDecl(varDecl),
      varDecl.bindings.count == 1,
      let binding = varDecl.bindings.first,
      let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)
    else {
      return false
    }

    let varName = identifierPattern.identifier.text

    guard let thenAssignment = try? extractSingleAssignment(from: ifExpr.body),
      let assignedName = thenAssignment.targetName
    else {
      return false
    }

    return varName == assignedName
  }

  private static func analyzePattern(
    variableDecl: VariableDeclSyntax?,
    ifExpr: IfExprSyntax,
    varIndex: Int?,
    ifIndex: Int
  ) throws -> ConvertibleIfElse? {

    var expectedVariableName: String?

    if let variableDecl {
      guard validateVariableDecl(variableDecl) else {
        return nil
      }

      guard variableDecl.bindings.count == 1,
        let binding = variableDecl.bindings.first,
        let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)
      else {
        return nil
      }
      expectedVariableName = identifierPattern.identifier.text
    }

    guard let firstCondition = ifExpr.conditions.only,
      case .expression(let condition) = firstCondition.condition
    else {
      return nil
    }

    guard let elseBody = ifExpr.elseBody,
      case .codeBlock(let elseBlock) = elseBody
    else {
      return nil
    }

    guard let thenAssignment = try extractSingleAssignment(from: ifExpr.body) else {
      return nil
    }

    guard let elseAssignment = try extractSingleAssignment(from: elseBlock) else {
      return nil
    }

    guard thenAssignment.isTuple == elseAssignment.isTuple else {
      return nil
    }

    guard normalized(thenAssignment.targetExpr) == normalized(elseAssignment.targetExpr) else {
      return nil
    }

    if let expectedName = expectedVariableName {
      guard let thenName = thenAssignment.targetName, thenName == expectedName else {
        return nil
      }
      guard elseAssignment.targetName == expectedName else {
        return nil
      }
    }

    if isExpressionTooComplexForTernary(thenAssignment.valueExpr)
      || isExpressionTooComplexForTernary(elseAssignment.valueExpr)
    {
      return nil
    }

    return ConvertibleIfElse(
      variableDecl: variableDecl,
      ifExpr: ifExpr,
      assignmentTargetExpr: thenAssignment.targetExpr,
      assignmentTargetName: thenAssignment.targetName,
      condition: condition,
      trueExpr: thenAssignment.valueExpr,
      falseExpr: elseAssignment.valueExpr,
      variableDeclIndex: varIndex,
      ifExprIndex: ifIndex,
      isTupleAssignment: thenAssignment.isTuple
    )
  }

  // MARK: - Validation Helpers
  private static func isNamedTupleType(_ type: TypeSyntax) -> Bool {
    guard let tupleType = type.as(TupleTypeSyntax.self) else { return false }
    return tupleType.elements.contains { $0.firstName != nil }
  }

  private static func validateVariableDecl(_ decl: VariableDeclSyntax) -> Bool {
    guard decl.bindings.count == 1,
      let binding = decl.bindings.first,
      binding.typeAnnotation?.type != nil,
      binding.initializer == nil,
      decl.attributes.isEmpty
    else {
      return false
    }

    let keyword = decl.bindingSpecifier.tokenKind
    return keyword == .keyword(.let) || keyword == .keyword(.var)
  }

  private static func normalized(_ expression: ExprSyntax) -> String {
    expression.trimmed.description
  }

  // MARK: - Extracting Assignments
  /// Extracts the assignment from a code block.
  private static func extractSingleAssignment(
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

  /// Extracts the target and value from a sequence expression containing assignment.
  private static func extractFromSequenceAssignment(
    _ sequenceExpr: SequenceExprSyntax
  ) throws -> AssignmentInfo? {

    let elements = Array(sequenceExpr.elements)

    guard elements.count == 3,
      elements[1].as(AssignmentExprSyntax.self) != nil
    else {
      return nil
    }

    let lhs = ExprSyntax(elements[0])
    let rhs = ExprSyntax(elements[2])

    if let lhsIdentifier = lhs.as(DeclReferenceExprSyntax.self) {
      return AssignmentInfo(
        targetExpr: lhs,
        targetName: lhsIdentifier.baseName.text,
        valueExpr: rhs,
        isTuple: false
      )
    }

    if lhs.as(TupleExprSyntax.self) != nil {
      guard rhs.as(TupleExprSyntax.self) != nil else {
        return nil
      }
      return AssignmentInfo(
        targetExpr: lhs,
        targetName: nil,
        valueExpr: rhs,
        isTuple: true
      )
    }

    return nil
  }

  private static func isExpressionTooComplexForTernary(_ expr: ExprSyntax) -> Bool {
    // Nested ternaries reduce readability: x = a ? b : (c ? d : e)
    if expr.as(TernaryExprSyntax.self) != nil { return true }

    // Closures in ternaries are harder to read than if-else blocks.
    // Example: action = condition ? { [weak self] in self?.log() } : { print("default") }
    // is less clear than an if-else with proper formatting and line breaks.
    if expr.as(ClosureExprSyntax.self) != nil { return true }

    return false
  }

  // MARK: - Applying Refactoring
  private static func performRefactoring(
    syntax: CodeBlockItemListSyntax,
    convertible: ConvertibleIfElse
  ) -> CodeBlockItemListSyntax {

    var newItems: [CodeBlockItemSyntax] = []

    for (index, item) in syntax.enumerated() {
      if index == convertible.ifExprIndex {
        if convertible.variableDecl == nil {
          let assignmentExpr = createTernaryAssignment(from: convertible)
          let assignmentStmt = ExpressionStmtSyntax(expression: assignmentExpr)
          newItems.append(
            CodeBlockItemSyntax(item: .stmt(StmtSyntax(assignmentStmt))).trimmed
          )
        }
        continue
      }

      if let varDeclIndex = convertible.variableDeclIndex, index == varDeclIndex {
        let newDecl = createTernaryDeclaration(from: convertible)
        newItems.append(
          CodeBlockItemSyntax(item: .decl(DeclSyntax(newDecl))).trimmed
        )
        continue
      }

      newItems.append(item)
    }

    return CodeBlockItemListSyntax(newItems)
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

  /// Creates the new variable declaration with ternary initializer (when declaration exists).
  /// Preserves the original pattern + type annotation.
  private static func createTernaryDeclaration(from convertible: ConvertibleIfElse) -> VariableDeclSyntax {
    guard let variableDecl = convertible.variableDecl else {
      fatalError("createTernaryDeclaration called without variable declaration")
    }
    guard let originalBinding = variableDecl.bindings.first else {
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
}
