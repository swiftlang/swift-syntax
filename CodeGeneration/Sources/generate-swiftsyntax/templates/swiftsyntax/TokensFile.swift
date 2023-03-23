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
    for token in SYNTAX_TOKENS {
      if token.isKeyword {
        DeclSyntax(
          """
          public static func \(raw: token.swiftKind)(
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(raw: token.swiftKind),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      } else if let text = token.text {
        DeclSyntax(
          """
          public static func \(raw: token.swiftKind)Token(
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(raw: token.swiftKind),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      } else if let associatedValueClass = token.associatedValueClass {
        DeclSyntax(
          """
          public static func \(raw: token.swiftKind)(
            _ value: \(raw: associatedValueClass),
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(raw: token.swiftKind)(value),
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
          public static func \(raw: token.swiftKind)(
            _ text: String,
            leadingTrivia: Trivia = [],
            trailingTrivia: Trivia = [],
            presence: SourcePresence = .present
          ) -> TokenSyntax {
            return TokenSyntax(
              .\(raw: token.swiftKind)(text),
              leadingTrivia: leadingTrivia,
              trailingTrivia: trailingTrivia,
              presence: presence
            )
          }
          """
        )
      }
    }

    DeclSyntax(
      """
      public static func eof(
        leadingTrivia: Trivia = [],
        presence: SourcePresence = .present
      ) -> TokenSyntax {
        return TokenSyntax(
          .eof,
          leadingTrivia: leadingTrivia,
          trailingTrivia: [],
          presence: presence
        )
      }
      """
    )
  }
}
