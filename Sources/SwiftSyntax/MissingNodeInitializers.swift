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

extension MissingDeclSyntax {
  public init(
    attributes: AttributeListSyntax,
    modifiers: DeclModifierListSyntax
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      placeholder: TokenSyntax.identifier("<#declaration#>")
    )
  }
}

extension MissingExprSyntax {
  public init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#expression#>")
    )
  }
}

extension MissingPatternSyntax {
  public init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#pattern#>")
    )
  }
}

extension MissingStmtSyntax {
  public init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#statement#>")
    )
  }
}

extension MissingTypeSyntax {
  public init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#type#>")
    )
  }
}

extension MissingSyntax {
  public init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#syntax#>")
    )
  }
}
