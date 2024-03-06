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

fileprivate extension OperatorKind {
  var keyword: Keyword {
    switch self {
    case .infix: return .infix
    case .prefix: return .prefix
    case .postfix: return .postfix
    }
  }
}

extension Operator {
  /// Synthesize a syntactic representation of this operator based on its
  /// semantic definition.
  public func synthesizedSyntax() -> OperatorDeclSyntax {
    let fixitySpecifier = TokenSyntax.keyword(kind.keyword)
    let operatorKeyword = TokenSyntax.keyword(.operator, leadingTrivia: .space)
    let name = TokenSyntax.binaryOperator(name, leadingTrivia: .space)
    let precedenceGroupSyntax = precedenceGroup.map { groupName in
      OperatorPrecedenceAndTypesSyntax(
        colon: .colonToken(),
        precedenceGroup: .identifier(groupName, leadingTrivia: .space),
        designatedTypes: DesignatedTypeListSyntax([])
      )
    }

    return OperatorDeclSyntax(
      fixitySpecifier: fixitySpecifier,
      operatorKeyword: operatorKeyword,
      name: name,
      operatorPrecedenceAndTypes: precedenceGroupSyntax
    )
  }
}

extension PrecedenceRelation {
  /// Synthesize a syntactic representation of this precedence relation based on
  /// its semantic definition.
  ///
  /// We only use this internally to synthesize syntactic locations.
  func synthesizedSyntax(
    indentation: Int = 4
  ) -> PrecedenceGroupRelationSyntax {
    PrecedenceGroupRelationSyntax(
      higherThanOrLowerThanLabel: .keyword(
        kind.keyword,
        leadingTrivia: [.newlines(1), .spaces(indentation)]
      ),
      colon: .colonToken(),
      precedenceGroups: PrecedenceGroupNameListSyntax(
        [
          PrecedenceGroupNameSyntax(
            name: .identifier(groupName, leadingTrivia: .space)
          )
        ]
      )
    )
  }
}

fileprivate extension Associativity {
  var keyword: Keyword {
    switch self {
    case .none: return .none
    case .left: return .left
    case .right: return .right
    }
  }
}

extension PrecedenceGroup {
  /// Synthesize a syntactic representation of this precedence group based on
  /// its semantic definition.
  public func synthesizedSyntax(
    indentation: Int = 4
  ) -> PrecedenceGroupDeclSyntax {
    let precedencegroupKeyword = TokenSyntax.keyword(.precedencegroup)
    let identifierSyntax =
      TokenSyntax.identifier(name, leadingTrivia: .space)
    let leftBrace = TokenSyntax.leftBraceToken(leadingTrivia: .space)

    var groupAttributes: [PrecedenceGroupAttributeListSyntax.Element] = []

    switch associativity {
    case .left, .right:
      groupAttributes.append(
        .init(
          PrecedenceGroupAssociativitySyntax(
            associativityLabel:
              .keyword(
                .associativity,
                leadingTrivia: [.newlines(1), .spaces(indentation)]
              ),
            colon: .colonToken(),
            value: .keyword(associativity.keyword, leadingTrivia: .space)
          )
        )
      )

    case .none:
      // None is the default associativity.
      break
    }

    if assignment {
      groupAttributes.append(
        .init(
          PrecedenceGroupAssignmentSyntax(
            assignmentLabel:
              .keyword(
                .assignment,
                leadingTrivia: [.newlines(1), .spaces(indentation)]
              ),
            colon: .colonToken(),
            value: .keyword(.true, leadingTrivia: .space)
          )
        )
      )
    }

    for relation in relations {
      groupAttributes.append(
        .init(
          relation.synthesizedSyntax()
        )
      )
    }

    let rightBrace = TokenSyntax.rightBraceToken(
      leadingTrivia: groupAttributes.isEmpty ? .space : .newline
    )

    return PrecedenceGroupDeclSyntax(
      precedencegroupKeyword: precedencegroupKeyword,
      name: identifierSyntax,
      leftBrace: leftBrace,
      groupAttributes: PrecedenceGroupAttributeListSyntax(groupAttributes),
      rightBrace: rightBrace
    )
  }
}
