//===------------------ SyntaxSynthesis.swift -----------------------------===//
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

import SwiftSyntax

extension Operator {
  /// Synthesize a syntactic representation of this operator based on its
  /// semantic definition.
  public func synthesizedSyntax() -> OperatorDeclSyntax {
    let modifiers = ModifierListSyntax(
      [DeclModifierSyntax(name: .identifier("\(kind)"), detail: nil)]
    )
    let operatorKeyword = TokenSyntax.operatorKeyword(leadingTrivia: .space)
    let identifierSyntax =
      TokenSyntax.identifier(name, leadingTrivia: .space)
    let precedenceGroupSyntax = precedenceGroup.map { groupName in
      OperatorPrecedenceAndTypesSyntax(
        colon: .colonToken(),
        precedenceGroup: .identifier(groupName, leadingTrivia: .space),
        designatedTypes: DesignatedTypeListSyntax([])
      )
    }

    return OperatorDeclSyntax(
      attributes: nil, modifiers: modifiers, operatorKeyword: operatorKeyword,
      identifier: identifierSyntax,
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
      higherThanOrLowerThan: .contextualKeyword(
        "\(kind)",
        leadingTrivia: [ .newlines(1), .spaces(indentation) ]
      ),
      colon: .colonToken(),
      otherNames: PrecedenceGroupNameListSyntax(
        [
          PrecedenceGroupNameElementSyntax(
            name: .identifier(groupName, leadingTrivia:  .space),
            trailingComma: nil)
        ]
      )
    )
  }
}

extension PrecedenceGroup {
  /// Synthesize a syntactic representation of this precedence group based on
  /// its semantic definition.
  public func synthesizedSyntax(
    indentation: Int = 4
  ) -> PrecedenceGroupDeclSyntax {
    let precedencegroupKeyword = TokenSyntax.precedencegroupKeyword()
    let identifierSyntax =
      TokenSyntax.identifier(name, leadingTrivia: .space)
    let leftBrace = TokenSyntax.leftBraceToken(leadingTrivia: .space)

    var groupAttributes: [Syntax] = []

    switch associativity {
    case .left, .right:
      groupAttributes.append(
        Syntax(
          PrecedenceGroupAssociativitySyntax(
            associativityKeyword:
                .identifier(
                  "associativity",
                  leadingTrivia: [ .newlines(1), .spaces(indentation) ]
                ),
            colon: .colonToken(),
            value: .identifier("\(associativity)", leadingTrivia: .space)
          )
        )
      )

    case .none:
      // None is the default associativity.
      break
    }

    if assignment {
      groupAttributes.append(
        Syntax(
          PrecedenceGroupAssignmentSyntax(
            assignmentKeyword:
                .identifier(
                  "assignment",
                  leadingTrivia: [ .newlines(1), .spaces(indentation) ]
                ),
            colon: .colonToken(),
            flag: .trueKeyword(leadingTrivia: .space)
          )
        )
      )
    }

    for relation in relations {
      groupAttributes.append(
        Syntax(
          relation.synthesizedSyntax()
        )
      )
    }

    let rightBrace = TokenSyntax.rightBraceToken(
      leadingTrivia: groupAttributes.isEmpty ? .space : .newline
    )

    return PrecedenceGroupDeclSyntax(
      attributes: nil, modifiers: nil,
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: identifierSyntax, leftBrace: leftBrace,
      groupAttributes: PrecedenceGroupAttributeListSyntax(groupAttributes),
      rightBrace: rightBrace
    )
  }
}
