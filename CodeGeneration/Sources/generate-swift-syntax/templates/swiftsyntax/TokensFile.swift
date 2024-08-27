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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let tokensFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! ExtensionDeclSyntax("extension TokenSyntax") {
    for tokenSpec in Token.allCases.map(\.spec) {
      if tokenSpec.text != nil {
        DeclSyntax(
          """
          public static func \(tokenSpec.identifier)Token(
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(tokenSpec.memberCallName),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      } else if tokenSpec.kind == .keyword {
        DeclSyntax(
          """
          public static func \(tokenSpec.funcDeclName)(
            _ value: Keyword,
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(tokenSpec.memberCallName)(value),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      } else {
        DeclSyntax(
          """
          public static func \(tokenSpec.funcDeclName)(
            _ text: String,
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(tokenSpec.memberCallName)(text),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      }
    }
  }
}
