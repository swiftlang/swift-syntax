//===----------------------------------------------------------------------===//
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

extension VariableDecl {
  /// Creates an optionally initialized property.
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    _ letOrVarKeyword: Token,
    name: ExpressibleAsIdentifierPattern,
    type: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes?.createAttributeList().withTrailingTrivia(.space),
      modifiers: modifiers,
      letOrVarKeyword: letOrVarKeyword
    ) {
      PatternBinding(
        pattern: name,
        typeAnnotation: type,
        initializer: initializer
      )
    }
  }

  /// Creates a computed property with the given accessor.
  public init(
    leadingTrivia: Trivia = [],
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    name: ExpressibleAsIdentifierPattern,
    type: ExpressibleAsTypeAnnotation,
    @CodeBlockItemListBuilder accessor: () -> ExpressibleAsCodeBlockItemList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes?.createAttributeList().withTrailingTrivia(.space),
      modifiers: modifiers,
      letOrVarKeyword: .var
    ) {
      PatternBinding(
        pattern: name,
        typeAnnotation: type,
        accessor: CodeBlock(statements: accessor())
      )
    }
  }
}
