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

/// Reads a tree by dispatching on the typed enum for a node's base kind, then
/// take that node's children through the generated accessors.
private final class TypedAccessorReader {
  /// Accumulates something from every child read, ensuring it's not optimized away.
  var checksum = 0

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

  func read(_ node: Syntax) {
    if let decl = node.as(DeclSyntax.self) {
      read(decl: decl)
    } else if let expr = node.as(ExprSyntax.self) {
      read(expr: expr)
    } else if let stmt = node.as(StmtSyntax.self) {
      read(stmt: stmt)
    } else if let type = node.as(TypeSyntax.self) {
      read(type: type)
    }
    for child in node.children(viewMode: .sourceAccurate) {
      read(child)
    }
  }

  private func read(decl node: DeclSyntax) {
    switch node.as(DeclSyntaxEnum.self) {
    case .functionDecl(let node):
      mix(node.funcKeyword)
      mix(node.name)
      mix(node.attributes.count)
      mix(node.modifiers.count)
      mix(node.genericParameterClause)
      mix(node.signature.parameterClause.parameters.count)
      mix(node.signature.returnClause?.type)
      mix(node.genericWhereClause)
      mix(node.body)
    case .structDecl(let node):
      mix(node.structKeyword)
      mix(node.name)
      mix(node.attributes.count)
      mix(node.modifiers.count)
      mix(node.genericParameterClause)
      mix(node.inheritanceClause?.inheritedTypes.count ?? 0)
      mix(node.memberBlock.members.count)
    case .classDecl(let node):
      mix(node.classKeyword)
      mix(node.name)
      mix(node.inheritanceClause?.inheritedTypes.count ?? 0)
      mix(node.memberBlock.members.count)
    case .enumDecl(let node):
      mix(node.enumKeyword)
      mix(node.name)
      mix(node.memberBlock.members.count)
    case .extensionDecl(let node):
      mix(node.extensionKeyword)
      mix(node.extendedType)
      mix(node.memberBlock.members.count)
    case .variableDecl(let node):
      mix(node.bindingSpecifier)
      mix(node.attributes.count)
      mix(node.modifiers.count)
      mix(node.bindings.count)
      for binding in node.bindings {
        mix(binding.pattern)
        mix(binding.typeAnnotation?.type)
        mix(binding.initializer?.value)
        mix(binding.accessorBlock)
      }
    case .initializerDecl(let node):
      mix(node.initKeyword)
      mix(node.signature.parameterClause.parameters.count)
      mix(node.body)
    case .typeAliasDecl(let node):
      mix(node.name)
      mix(node.initializer.value)
    case .associatedTypeDecl(let node):
      mix(node.name)
      mix(node.inheritanceClause?.inheritedTypes.count ?? 0)
    case .importDecl(let node):
      mix(node.importKeyword)
      mix(node.path.count)
    default:
      mix(node.trimmedLength.utf8Length)
    }
  }

  private func read(expr node: ExprSyntax) {
    switch node.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let node):
      mix(node.calledExpression)
      mix(node.leftParen)
      mix(node.arguments.count)
      for argument in node.arguments {
        mix(argument.label)
        mix(argument.expression)
      }
      mix(node.trailingClosure)
      mix(node.additionalTrailingClosures.count)
    case .memberAccessExpr(let node):
      mix(node.base)
      mix(node.period)
      mix(node.declName.baseName)
    case .declReferenceExpr(let node):
      mix(node.baseName)
      mix(node.argumentNames?.arguments.count ?? 0)
    case .infixOperatorExpr(let node):
      mix(node.leftOperand)
      mix(node.operator)
      mix(node.rightOperand)
    case .stringLiteralExpr(let node):
      mix(node.openingQuote)
      mix(node.segments.count)
      mix(node.closingQuote)
    case .closureExpr(let node):
      mix(node.signature?.parameterClause)
      mix(node.statements.count)
    case .subscriptCallExpr(let node):
      mix(node.calledExpression)
      mix(node.arguments.count)
    case .tupleExpr(let node):
      mix(node.elements.count)
    case .sequenceExpr(let node):
      mix(node.elements.count)
    default:
      mix(node.trimmedLength.utf8Length)
    }
  }

  private func read(stmt node: StmtSyntax) {
    switch node.as(StmtSyntaxEnum.self) {
    case .returnStmt(let node):
      mix(node.returnKeyword)
      mix(node.expression)
    case .guardStmt(let node):
      mix(node.conditions.count)
      mix(node.body.statements.count)
    case .forStmt(let node):
      mix(node.pattern)
      mix(node.sequence)
      mix(node.body.statements.count)
    case .whileStmt(let node):
      mix(node.conditions.count)
      mix(node.body.statements.count)
    default:
      mix(node.trimmedLength.utf8Length)
    }
  }

  private func read(type node: TypeSyntax) {
    switch node.as(TypeSyntaxEnum.self) {
    case .identifierType(let node):
      mix(node.name)
      mix(node.genericArgumentClause?.arguments.count ?? 0)
    case .memberType(let node):
      mix(node.baseType)
      mix(node.name)
    case .optionalType(let node):
      mix(node.wrappedType)
    case .arrayType(let node):
      mix(node.element)
    case .functionType(let node):
      mix(node.parameters.count)
      mix(node.returnClause.type)
    default:
      mix(node.trimmedLength.utf8Length)
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

  /// Walks a parsed tree reading every node through its typed accessors.
  func testTypedAccessorTraversalPerformance() throws {
    try XCTSkipIf(longTestsDisabled)

    let source = try String(contentsOf: inputFile, encoding: .utf8)
    let parsed = Parser.parse(source: source)

    let reader = TypedAccessorReader()
    try measureInstructions {
      reader.read(Syntax(parsed))
    }
    XCTAssertNotEqual(reader.checksum, 0, "the reads must not be optimized away")
  }
}
