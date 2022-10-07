//===--- SyntaxUtils.swift ------------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

struct SpecifierWithToken {
  let specifier: EffectsSpecifier?
  let token: RawTokenSyntax
}

extension RawUnexpectedNodesSyntax {
  /// Returns `true` if this contains a token that satisfies `condition`.
  func containsToken(where condition: (RawTokenSyntax) -> Bool) -> Bool {
    return self.elements.contains(where: { node in
      if let token = node.as(RawTokenSyntax.self) {
        return condition(token)
      } else {
        return false
      }
    })
  }

  /// If `tokens` is not empty, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?(_ tokens: [RawTokenSyntax], arena: SyntaxArena) {
    if tokens.isEmpty {
      return nil
    } else {
      self.init(elements: tokens.map(RawSyntax.init), arena: arena)
    }
  }

  /// If `specifiers` is not empty, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?(_ specifiers: [SpecifierWithToken], arena: SyntaxArena) {
    if specifiers.isEmpty {
      return nil
    } else {
      self.init(elements: specifiers.map { RawSyntax($0.token) }, arena: arena)
    }
  }
}
