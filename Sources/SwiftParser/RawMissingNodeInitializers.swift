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

#if compiler(>=6)
@_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

// MARK: - Raw

extension RawMissingDeclSyntax {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    arena: __shared RawSyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#declaration#>", arena: arena),
      arena: arena
    )
  }
}

extension RawMissingExprSyntax {
  init(arena: __shared RawSyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#expression#>", arena: arena),
      arena: arena
    )
  }
}

extension RawMissingPatternSyntax {
  init(arena: __shared RawSyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#pattern#>", arena: arena),
      arena: arena
    )
  }
}

extension RawMissingStmtSyntax {
  init(arena: __shared RawSyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#statement#>", arena: arena),
      arena: arena
    )
  }
}

extension RawMissingTypeSyntax {
  init(arena: __shared RawSyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#type#>", arena: arena),
      arena: arena
    )
  }
}

extension RawMissingSyntax {
  init(arena: __shared RawSyntaxArena) {
    self.init(
      placeholder: RawTokenSyntax(missing: .identifier, text: "<#syntax#>", arena: arena),
      arena: arena
    )
  }
}
