//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
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

extension PrecedenceGroup {
  /// Form the semantic definition of a precedence group given its syntax.
  ///
  /// TODO: This ignores all semantic errors.
  init(from syntax: PrecedenceGroupDeclSyntax) {
    self.name = syntax.name.text
    self.syntax = syntax

    for attr in syntax.groupAttributes {
      switch attr {
      // Relation (lowerThan, higherThan)
      case .precedenceGroupRelation(let relation):
        let isLowerThan = relation.higherThanOrLowerThanLabel.tokenKind == .keyword(.lowerThan)
        for otherGroup in relation.precedenceGroups {
          let otherGroupName = otherGroup.name.text
          let relationKind: PrecedenceRelation.Kind =
            isLowerThan
            ? .lowerThan
            : .higherThan
          let relation = PrecedenceRelation(
            kind: relationKind,
            groupName: otherGroupName,
            syntax: otherGroup
          )
          self.relations.append(relation)
        }

      // Assignment
      case .precedenceGroupAssignment(let assignment):
        self.assignment = assignment.value.tokenKind == .keyword(.true)

      // Associativity
      case .precedenceGroupAssociativity(let associativity):
        switch associativity.value.tokenKind {
        case .keyword(.left):
          self.associativity = .left

        case .keyword(.right):
          self.associativity = .right

        case .keyword(.none):
          self.associativity = .none

        default:
          break
        }
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }
  }
}

extension Operator {
  /// Form the semantic definition of an operator given its syntax.
  ///
  /// TODO: This ignores all semantic errors.
  init(from syntax: OperatorDeclSyntax) {
    self.syntax = syntax
    kind = OperatorKind(rawValue: syntax.fixitySpecifier.text) ?? .infix

    name = syntax.name.text

    precedenceGroup = syntax.operatorPrecedenceAndTypes?.precedenceGroup.text
  }
}

extension OperatorTable {
  /// Integrate the operator and precedence group declarations from the given
  /// source file into the operator precedence tables.
  public mutating func addSourceFile(
    _ sourceFile: SourceFileSyntax,
    errorHandler: OperatorErrorHandler = { throw $0 }
  ) rethrows {
    class OperatorAndGroupVisitor: SyntaxAnyVisitor {
      var opPrecedence: OperatorTable
      var errors: [OperatorError] = []

      init(opPrecedence: OperatorTable) {
        self.opPrecedence = opPrecedence
        super.init(viewMode: .fixedUp)
      }

      private func errorHandler(error: OperatorError) {
        errors.append(error)
      }

      override func visit(
        _ node: OperatorDeclSyntax
      ) -> SyntaxVisitorContinueKind {
        opPrecedence.record(
          Operator(from: node),
          errorHandler: errorHandler
        )
        return .skipChildren
      }

      override func visit(
        _ node: PrecedenceGroupDeclSyntax
      ) -> SyntaxVisitorContinueKind {
        opPrecedence.record(
          PrecedenceGroup(from: node),
          errorHandler: errorHandler
        )
        return .skipChildren
      }

      // Only visit top-level entities to find operators and precedence groups.
      override func visit(
        _ node: SourceFileSyntax
      ) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }

      override func visit(
        _ node: CodeBlockItemListSyntax
      ) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }

      override func visit(
        _ node: CodeBlockItemSyntax
      ) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }

      // Everything else stops the visitation.
      override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        return .skipChildren
      }
    }

    let visitor = OperatorAndGroupVisitor(opPrecedence: self)
    visitor.walk(sourceFile)
    try visitor.errors.forEach(errorHandler)
    self = visitor.opPrecedence
  }
}
