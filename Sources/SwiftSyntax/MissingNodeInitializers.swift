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

public extension MissingDeclSyntax {
  init(
    attributes: AttributeListSyntax,
    modifiers: DeclModifierListSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      placeholder: TokenSyntax.identifier("<#declaration#>")
    )
  }
}

public extension MissingExprSyntax {
  init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#expression#>")
    )
  }
}

public extension MissingPatternSyntax {
  init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#pattern#>")
    )
  }
}

public extension MissingStmtSyntax {
  init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#statement#>")
    )
  }
}

public extension MissingTypeSyntax {
  init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#type#>")
    )
  }
}

public extension MissingSyntax {
  init() {
    self.init(
      placeholder: TokenSyntax.identifier("<#syntax#>")
    )
  }
}

// MARK: - Raw

public extension RawMissingDeclSyntax {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#declaration#>", arena: arena),
      arena: arena
    )
  }
}

public extension RawMissingExprSyntax {
  init(arena: __shared SyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#expression#>", arena: arena),
      arena: arena
    )
  }
}

public extension RawMissingPatternSyntax {
  init(arena: __shared SyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#pattern#>", arena: arena),
      arena: arena
    )
  }
}

public extension RawMissingStmtSyntax {
  init(arena: __shared SyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#statement#>", arena: arena),
      arena: arena
    )
  }
}

public extension RawMissingTypeSyntax {
  init(arena: __shared SyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#type#>", arena: arena),
      arena: arena
    )
  }
}

public extension RawMissingSyntax {
  init(arena: __shared SyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#syntax#>", arena: arena),
      arena: arena
    )
  }
}
