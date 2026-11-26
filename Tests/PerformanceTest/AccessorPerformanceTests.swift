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

import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Reads a tree the way a client that generates something from it does, which is
/// how ASTGen reads one: dispatch on the typed enum for a node's base kind, take
/// that node's children through the generated accessors, and recurse into the
/// children it took. A list is iterated as a ``SyntaxCollection``, so a member
/// block or a function body is walked by its elements rather than by asking the
/// tree for a node's children.
///
/// That distinction is the point of this benchmark. Asking a node for
/// `children(viewMode:)` walks every position a kind's layout names, absent ones
/// included, and builds a `Syntax` for each; a client reaching for
/// `node.memberBlock.members` and iterating it does neither. The two exercise
/// different paths through a node's storage, and only the second is what a
/// compiler front end costs.
///
/// A kind this reader does not name is walked generically instead, so the whole
/// file is still read. ``AccessorPerformanceTests/testTypedAccessorCoverage`` holds
/// that share under a percent, because at any more than that this measures the
/// generic walk again.
private final class TypedAccessorReader {
  /// Accumulates something from every child read, ensuring it's not optimized away.
  var checksum = 0

  /// Nodes dispatched by kind, and nodes this reader did not name.
  var typedNodes = 0
  var untypedNodes = 0

  private func mix(_ value: Int) {
    checksum = checksum &* 31 &+ value
  }

  private func mix(_ token: TokenSyntax?) {
    guard let token else { return mix(0) }
    mix(token.positionAfterSkippingLeadingTrivia.utf8Offset)
    mix(token.text.utf8.count)
  }

  private func mix(_ node: (some SyntaxProtocol)?) {
    mix(node.map { $0.trimmedLength.utf8Length } ?? 0)
  }

  // MARK: - The tree's spine

  func read(sourceFile node: SourceFileSyntax) {
    read(codeBlockItemList: node.statements)
    mix(node.endOfFileToken)
  }

  private func read(codeBlockItemList node: CodeBlockItemListSyntax) {
    for item in node {
      switch item.item {
      case .decl(let node): read(decl: node)
      case .stmt(let node): read(stmt: node)
      case .expr(let node): read(expr: node)
      }
    }
  }

  private func read(codeBlock node: CodeBlockSyntax?) {
    guard let node else { return mix(0) }
    mix(node.leftBrace)
    read(codeBlockItemList: node.statements)
    mix(node.rightBrace)
  }

  private func read(memberBlock node: MemberBlockSyntax) {
    mix(node.leftBrace)
    for member in node.members {
      read(decl: member.decl)
      mix(member.semicolon)
    }
    mix(node.rightBrace)
  }

  // MARK: - Declarations

  private func read(decl node: DeclSyntax) {
    typedNodes += 1
    switch node.as(DeclSyntaxEnum.self) {
    case .functionDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.funcKeyword)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(functionSignature: node.signature)
      read(genericWhereClause: node.genericWhereClause)
      read(codeBlock: node.body)
    case .initializerDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.initKeyword)
      read(genericParameterClause: node.genericParameterClause)
      read(functionSignature: node.signature)
      read(genericWhereClause: node.genericWhereClause)
      read(codeBlock: node.body)
    case .deinitializerDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      read(codeBlock: node.body)
    case .subscriptDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      read(genericParameterClause: node.genericParameterClause)
      read(functionParameterClause: node.parameterClause)
      read(type: node.returnClause.type)
      read(genericWhereClause: node.genericWhereClause)
      read(accessorBlock: node.accessorBlock)
    case .variableDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.bindingSpecifier)
      for binding in node.bindings {
        read(pattern: binding.pattern)
        if let type = binding.typeAnnotation?.type { read(type: type) }
        if let value = binding.initializer?.value { read(expr: value) }
        read(accessorBlock: binding.accessorBlock)
      }
    case .structDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.structKeyword)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(inheritanceClause: node.inheritanceClause)
      read(genericWhereClause: node.genericWhereClause)
      read(memberBlock: node.memberBlock)
    case .classDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.classKeyword)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(inheritanceClause: node.inheritanceClause)
      read(genericWhereClause: node.genericWhereClause)
      read(memberBlock: node.memberBlock)
    case .actorDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(inheritanceClause: node.inheritanceClause)
      read(memberBlock: node.memberBlock)
    case .enumDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.enumKeyword)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(inheritanceClause: node.inheritanceClause)
      read(memberBlock: node.memberBlock)
    case .enumCaseDecl(let node):
      read(attributeList: node.attributes)
      for element in node.elements {
        mix(element.name)
        if let parameters = element.parameterClause?.parameters {
          for parameter in parameters {
            mix(parameter.firstName)
            read(type: parameter.type)
          }
        }
        if let value = element.rawValue?.value { read(expr: value) }
      }
    case .protocolDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.name)
      read(inheritanceClause: node.inheritanceClause)
      read(genericWhereClause: node.genericWhereClause)
      read(memberBlock: node.memberBlock)
    case .extensionDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.extensionKeyword)
      read(type: node.extendedType)
      read(inheritanceClause: node.inheritanceClause)
      read(genericWhereClause: node.genericWhereClause)
      read(memberBlock: node.memberBlock)
    case .typeAliasDecl(let node):
      read(attributeList: node.attributes)
      read(modifierList: node.modifiers)
      mix(node.name)
      read(genericParameterClause: node.genericParameterClause)
      read(type: node.initializer.value)
    case .associatedTypeDecl(let node):
      read(attributeList: node.attributes)
      mix(node.name)
      read(inheritanceClause: node.inheritanceClause)
      read(genericWhereClause: node.genericWhereClause)
    case .accessorDecl(let node):
      read(attributeList: node.attributes)
      mix(node.accessorSpecifier)
      read(codeBlock: node.body)
    case .importDecl(let node):
      read(attributeList: node.attributes)
      mix(node.importKeyword)
      for component in node.path {
        mix(component.name)
      }
    case .macroExpansionDecl(let node):
      mix(node.macroName)
      read(labeledExprList: node.arguments)
      if let closure = node.trailingClosure { read(closureExpr: closure) }
    case .ifConfigDecl(let node):
      read(ifConfigDecl: node)
    default:
      readGenerically(Syntax(node))
    }
  }

  private func read(functionSignature node: FunctionSignatureSyntax) {
    read(functionParameterClause: node.parameterClause)
    mix(node.effectSpecifiers?.asyncSpecifier)
    if let type = node.returnClause?.type { read(type: type) }
  }

  private func read(functionParameterClause node: FunctionParameterClauseSyntax) {
    mix(node.leftParen)
    for parameter in node.parameters {
      read(attributeList: parameter.attributes)
      read(modifierList: parameter.modifiers)
      mix(parameter.firstName)
      mix(parameter.secondName)
      read(type: parameter.type)
      if let value = parameter.defaultValue?.value { read(expr: value) }
    }
    mix(node.rightParen)
  }

  private func read(attributeList node: AttributeListSyntax) {
    for attribute in node {
      switch attribute {
      case .attribute(let node):
        mix(node.atSign)
        read(type: node.attributeName)
        if case .argumentList(let arguments) = node.arguments {
          read(labeledExprList: arguments)
        }
      case .ifConfigDecl(let node):
        read(ifConfigDecl: node)
      }
    }
  }

  private func read(modifierList node: DeclModifierListSyntax) {
    for modifier in node {
      mix(modifier.name)
      mix(modifier.detail?.detail)
    }
  }

  private func read(inheritanceClause node: InheritanceClauseSyntax?) {
    guard let node else { return mix(0) }
    for inherited in node.inheritedTypes {
      read(type: inherited.type)
    }
  }

  private func read(genericParameterClause node: GenericParameterClauseSyntax?) {
    guard let node else { return mix(0) }
    for parameter in node.parameters {
      read(attributeList: parameter.attributes)
      mix(parameter.name)
      if let type = parameter.inheritedType { read(type: type) }
    }
    read(genericWhereClause: node.genericWhereClause)
  }

  private func read(genericWhereClause node: GenericWhereClauseSyntax?) {
    guard let node else { return mix(0) }
    for requirement in node.requirements {
      switch requirement.requirement {
      case .conformanceRequirement(let node):
        read(type: node.leftType)
        read(type: node.rightType)
      case .sameTypeRequirement(let node):
        mix(node.leftType)
        mix(node.rightType)
      case .layoutRequirement(let node):
        read(type: node.type)
      }
    }
  }

  private func read(accessorBlock node: AccessorBlockSyntax?) {
    guard let node else { return mix(0) }
    switch node.accessors {
    case .accessors(let accessors):
      for accessor in accessors {
        read(decl: DeclSyntax(accessor))
      }
    case .getter(let statements):
      read(codeBlockItemList: statements)
    }
  }

  private func read(ifConfigDecl node: IfConfigDeclSyntax) {
    for clause in node.clauses {
      if let condition = clause.condition { read(expr: condition) }
      switch clause.elements {
      case .statements(let statements): read(codeBlockItemList: statements)
      case .decls(let members):
        for member in members { read(decl: member.decl) }
      case .switchCases(let cases): read(switchCaseList: cases)
      case .postfixExpression(let expression): read(expr: expression)
      case .attributes(let attributes): read(attributeList: attributes)
      case nil: mix(0)
      }
    }
  }

  // MARK: - Expressions

  private func read(expr node: ExprSyntax) {
    typedNodes += 1
    switch node.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let node):
      mix(node.baseName)
      if let arguments = node.argumentNames?.arguments {
        for argument in arguments { mix(argument.name) }
      }
    case .memberAccessExpr(let node):
      if let base = node.base { read(expr: base) }
      mix(node.period)
      mix(node.declName.baseName)
    case .functionCallExpr(let node):
      read(expr: node.calledExpression)
      mix(node.leftParen)
      read(labeledExprList: node.arguments)
      mix(node.rightParen)
      if let closure = node.trailingClosure { read(closureExpr: closure) }
      for additional in node.additionalTrailingClosures {
        mix(additional.label)
        read(closureExpr: additional.closure)
      }
    case .subscriptCallExpr(let node):
      read(expr: node.calledExpression)
      read(labeledExprList: node.arguments)
      if let closure = node.trailingClosure { read(closureExpr: closure) }
    case .infixOperatorExpr(let node):
      read(expr: node.leftOperand)
      read(expr: node.operator)
      read(expr: node.rightOperand)
    case .prefixOperatorExpr(let node):
      mix(node.operator)
      read(expr: node.expression)
    case .postfixOperatorExpr(let node):
      read(expr: node.expression)
      mix(node.operator)
    case .binaryOperatorExpr(let node):
      mix(node.operator)
    case .sequenceExpr(let node):
      for element in node.elements { read(expr: element) }
    case .tupleExpr(let node):
      read(labeledExprList: node.elements)
    case .arrayExpr(let node):
      for element in node.elements { read(expr: element.expression) }
    case .dictionaryExpr(let node):
      if case .elements(let elements) = node.content {
        for element in elements {
          read(expr: element.key)
          read(expr: element.value)
        }
      }
    case .closureExpr(let node):
      read(closureExpr: node)
    case .stringLiteralExpr(let node):
      mix(node.openingQuote)
      for segment in node.segments {
        switch segment {
        case .stringSegment(let node): mix(node.content)
        case .expressionSegment(let node): read(labeledExprList: node.expressions)
        }
      }
      mix(node.closingQuote)
    case .integerLiteralExpr(let node):
      mix(node.literal)
    case .floatLiteralExpr(let node):
      mix(node.literal)
    case .booleanLiteralExpr(let node):
      mix(node.literal)
    case .nilLiteralExpr(let node):
      mix(node.nilKeyword)
    case .ifExpr(let node):
      read(conditionList: node.conditions)
      read(codeBlock: node.body)
      switch node.elseBody {
      case .codeBlock(let node): read(codeBlock: node)
      case .ifExpr(let node): read(expr: ExprSyntax(node))
      case nil: mix(0)
      }
    case .switchExpr(let node):
      read(expr: node.subject)
      read(switchCaseList: node.cases)
    case .tryExpr(let node):
      mix(node.tryKeyword)
      read(expr: node.expression)
    case .awaitExpr(let node):
      read(expr: node.expression)
    case .forceUnwrapExpr(let node):
      read(expr: node.expression)
    case .optionalChainingExpr(let node):
      read(expr: node.expression)
    case .asExpr(let node):
      read(expr: node.expression)
      read(type: node.type)
    case .isExpr(let node):
      read(expr: node.expression)
      read(type: node.type)
    case .assignmentExpr(let node):
      mix(node.equal)
    case .ternaryExpr(let node):
      read(expr: node.condition)
      read(expr: node.thenExpression)
      read(expr: node.elseExpression)
    case .genericSpecializationExpr(let node):
      read(expr: node.expression)
      read(genericArgumentClause: node.genericArgumentClause)
    case .macroExpansionExpr(let node):
      mix(node.macroName)
      read(labeledExprList: node.arguments)
      if let closure = node.trailingClosure { read(closureExpr: closure) }
    case .keyPathExpr(let node):
      mix(node.backslash)
      if let root = node.root { read(type: root) }
    case .discardAssignmentExpr(let node):
      mix(node.wildcard)
    case .superExpr(let node):
      mix(node.superKeyword)
    case .patternExpr(let node):
      read(pattern: node.pattern)
    default:
      readGenerically(Syntax(node))
    }
  }

  private func read(closureExpr node: ClosureExprSyntax) {
    if let signature = node.signature {
      read(attributeList: signature.attributes)
      if let capture = signature.capture {
        for item in capture.items {
          mix(item.name)
          if let value = item.initializer?.value { read(expr: value) }
        }
      }
      switch signature.parameterClause {
      case .simpleInput(let parameters):
        for parameter in parameters { mix(parameter.name) }
      case .parameterClause(let clause):
        for parameter in clause.parameters {
          mix(parameter.firstName)
          if let type = parameter.type { read(type: type) }
        }
      case nil:
        mix(0)
      }
      if let type = signature.returnClause?.type { read(type: type) }
    }
    read(codeBlockItemList: node.statements)
  }

  private func read(labeledExprList node: LabeledExprListSyntax) {
    for argument in node {
      mix(argument.label)
      read(expr: argument.expression)
    }
  }

  // MARK: - Statements

  private func read(stmt node: StmtSyntax) {
    typedNodes += 1
    switch node.as(StmtSyntaxEnum.self) {
    case .returnStmt(let node):
      mix(node.returnKeyword)
      if let expression = node.expression { read(expr: expression) }
    case .expressionStmt(let node):
      read(expr: node.expression)
    case .guardStmt(let node):
      read(conditionList: node.conditions)
      read(codeBlock: node.body)
    case .forStmt(let node):
      read(pattern: node.pattern)
      if let type = node.typeAnnotation?.type { read(type: type) }
      read(expr: node.sequence)
      if let condition = node.whereClause?.condition { read(expr: condition) }
      read(codeBlock: node.body)
    case .whileStmt(let node):
      read(conditionList: node.conditions)
      read(codeBlock: node.body)
    case .repeatStmt(let node):
      read(codeBlock: node.body)
      read(expr: node.condition)
    case .doStmt(let node):
      read(codeBlock: node.body)
      for clause in node.catchClauses {
        for item in clause.catchItems {
          if let pattern = item.pattern { read(pattern: pattern) }
          if let condition = item.whereClause?.condition { read(expr: condition) }
        }
        read(codeBlock: clause.body)
      }
    case .deferStmt(let node):
      read(codeBlock: node.body)
    case .throwStmt(let node):
      read(expr: node.expression)
    case .labeledStmt(let node):
      mix(node.label)
      read(stmt: node.statement)
    case .breakStmt(let node):
      mix(node.label)
    case .continueStmt(let node):
      mix(node.label)
    case .fallThroughStmt(let node):
      mix(node.fallthroughKeyword)
    case .yieldStmt(let node):
      mix(node.yieldKeyword)
    case .discardStmt(let node):
      read(expr: node.expression)
    default:
      readGenerically(Syntax(node))
    }
  }

  private func read(conditionList node: ConditionElementListSyntax) {
    for element in node {
      switch element.condition {
      case .expression(let node):
        read(expr: node)
      case .optionalBinding(let node):
        mix(node.bindingSpecifier)
        read(pattern: node.pattern)
        if let type = node.typeAnnotation?.type { read(type: type) }
        if let value = node.initializer?.value { read(expr: value) }
      case .matchingPattern(let node):
        read(pattern: node.pattern)
        read(expr: node.initializer.value)
      case .availability(let node):
        mix(node.availabilityKeyword)
      }
    }
  }

  private func read(switchCaseList node: SwitchCaseListSyntax) {
    for element in node {
      switch element {
      case .switchCase(let node):
        switch node.label {
        case .case(let label):
          for item in label.caseItems {
            read(pattern: item.pattern)
            if let condition = item.whereClause?.condition { read(expr: condition) }
          }
        case .default(let label):
          mix(label.defaultKeyword)
        }
        read(codeBlockItemList: node.statements)
      case .ifConfigDecl(let node):
        read(ifConfigDecl: node)
      case .macroExpansionDecl(let node):
        read(decl: DeclSyntax(node))
      }
    }
  }

  // MARK: - Patterns and types

  private func read(pattern node: PatternSyntax) {
    typedNodes += 1
    switch node.as(PatternSyntaxEnum.self) {
    case .identifierPattern(let node):
      mix(node.identifier)
    case .wildcardPattern(let node):
      mix(node.wildcard)
    case .tuplePattern(let node):
      for element in node.elements {
        mix(element.label)
        read(pattern: element.pattern)
      }
    case .valueBindingPattern(let node):
      mix(node.bindingSpecifier)
      read(pattern: node.pattern)
    case .expressionPattern(let node):
      read(expr: node.expression)
    case .isTypePattern(let node):
      read(type: node.type)
    default:
      readGenerically(Syntax(node))
    }
  }

  private func read(type node: TypeSyntax) {
    typedNodes += 1
    switch node.as(TypeSyntaxEnum.self) {
    case .identifierType(let node):
      mix(node.name)
      read(genericArgumentClause: node.genericArgumentClause)
    case .memberType(let node):
      read(type: node.baseType)
      mix(node.name)
      read(genericArgumentClause: node.genericArgumentClause)
    case .optionalType(let node):
      read(type: node.wrappedType)
    case .implicitlyUnwrappedOptionalType(let node):
      read(type: node.wrappedType)
    case .arrayType(let node):
      read(type: node.element)
    case .dictionaryType(let node):
      read(type: node.key)
      read(type: node.value)
    case .tupleType(let node):
      for element in node.elements {
        mix(element.firstName)
        read(type: element.type)
      }
    case .functionType(let node):
      for parameter in node.parameters {
        read(type: parameter.type)
      }
      read(type: node.returnClause.type)
    case .attributedType(let node):
      read(attributeList: node.attributes)
      read(type: node.baseType)
    case .someOrAnyType(let node):
      mix(node.someOrAnySpecifier)
      read(type: node.constraint)
    case .metatypeType(let node):
      read(type: node.baseType)
      mix(node.metatypeSpecifier)
    case .compositionType(let node):
      for element in node.elements {
        read(type: element.type)
      }
    default:
      readGenerically(Syntax(node))
    }
  }

  private func read(genericArgumentClause node: GenericArgumentClauseSyntax?) {
    guard let node else { return mix(0) }
    for argument in node.arguments {
      if case .type(let type) = argument.argument { read(type: type) }
    }
  }

  // MARK: - The fallback

  /// Walks a node this reader does not name, so that a kind it has not been taught
  /// does not silently cut a subtree out of the measurement. Children reached this
  /// way rejoin the typed path as soon as one of them has a base kind.
  private func readGenerically(_ node: Syntax) {
    untypedNodes += 1
    mix(node.trimmedLength.utf8Length)
    for child in node.children(viewMode: .sourceAccurate) {
      if let node = child.as(DeclSyntax.self) {
        read(decl: node)
      } else if let node = child.as(ExprSyntax.self) {
        read(expr: node)
      } else if let node = child.as(StmtSyntax.self) {
        read(stmt: node)
      } else if let node = child.as(TypeSyntax.self) {
        read(type: node)
      } else if let node = child.as(PatternSyntax.self) {
        read(pattern: node)
      } else if let token = child.as(TokenSyntax.self) {
        mix(token)
      } else {
        readGenerically(child)
      }
    }
  }
}

final class AccessorPerformanceTests: XCTestCase {
  private var inputFile: URL {
    return URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  /// Reads a parsed tree through its typed accessors, iterating each list as a
  /// collection, which is the shape of every client that generates something from a
  /// tree.
  func testTypedAccessorTraversalPerformance() throws {
    try XCTSkipIf(longTestsDisabled)

    let source = try String(contentsOf: inputFile, encoding: .utf8)
    let parsed = Parser.parse(source: source)

    let reader = TypedAccessorReader()
    try measureInstructions {
      reader.read(sourceFile: parsed)
    }
    XCTAssertNotEqual(reader.checksum, 0, "the reads must not be optimized away")
  }

  /// What the benchmark above measures is the typed path, so the kinds it names have
  /// to account for nearly all of the tree. A kind it does not name is walked
  /// generically, which reads a node's children the way the benchmark exists to
  /// avoid, so that share is held to a rounding error rather than left to drift.
  func testTypedAccessorCoverage() throws {
    let source = try String(contentsOf: inputFile, encoding: .utf8)
    let parsed = Parser.parse(source: source)

    let reader = TypedAccessorReader()
    reader.read(sourceFile: parsed)

    let dispatched = reader.typedNodes + reader.untypedNodes
    XCTAssertGreaterThan(dispatched, 10_000, "the input should exercise a large tree")
    XCTAssertLessThan(
      Double(reader.untypedNodes) / Double(dispatched),
      0.01,
      """
      \(reader.untypedNodes) of \(dispatched) nodes were walked generically rather \
      than through the typed accessors. Teach the reader the kinds it is meeting, \
      or this measures `children(viewMode:)` instead.
      """
    )
  }
}
