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

extension FunctionDecl {
  /// A convenience initializer that allows passing in members using a result builder instead of having to wrap them in a `MemberDeclBlock`.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemList? = { nil }
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause,
      signature: signature,
      genericWhereClause: genericWhereClause,
      body: bodyBuilder()
    )
  }
}
