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
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let tokensFile = SourceFile(
  leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
    FunctionDecl("""
    fileprivate func defaultTrivia(presence: SourcePresence, trivia: Trivia) -> Trivia {
      switch presence {
      case .present:
        return trivia
      case .missing:
        return []
      }
    }
    """)
    
    ExtensionDecl("extension TokenSyntax") {
      for token in SYNTAX_TOKENS {
        if token.isKeyword {
          FunctionDecl("""
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
          """)
        } else if let text = token.text {
          FunctionDecl("""
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
          """)
        } else {
          FunctionDecl("""
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
          """)
        }
      }
      
      FunctionDecl("""
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
      """)
    }
  }
