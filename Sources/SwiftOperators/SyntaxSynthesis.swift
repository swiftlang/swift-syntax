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
    let operatorKeyword = TokenSyntax.operatorKeyword(leadingTrivia: .spaces(1))
    let identifierSyntax =
      TokenSyntax.identifier(name, leadingTrivia: .spaces(1))
    let precedenceGroupSyntax = precedenceGroup.map { groupName in
      OperatorPrecedenceAndTypesSyntax(
        colon: .colonToken(),
        precedenceGroupAndDesignatedTypes: IdentifierListSyntax(
          [.identifier(groupName, leadingTrivia: .spaces(1))]
        )
      )
    }

    return OperatorDeclSyntax(
      attributes: nil, modifiers: modifiers, operatorKeyword: operatorKeyword,
      identifier: identifierSyntax,
      operatorPrecedenceAndTypes: precedenceGroupSyntax
    )
  }
}
