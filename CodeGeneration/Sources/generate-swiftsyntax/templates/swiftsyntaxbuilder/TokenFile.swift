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

let tokenFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  ExtensionDecl("public extension TokenSyntax") {
    for token in SYNTAX_TOKENS {
      if token.isKeyword {
        VariableDecl("""
          /// The `\(raw: token.text!)` keyword
          static var \(raw: token.name.withFirstCharacterLowercased.backticked): Token {
            return .\(raw: token.swiftKind)()
          }
          """
        )
      } else if let text = token.text {
        VariableDecl("""
          /// The `\(raw: text)` token
          static var \(raw: token.name.withFirstCharacterLowercased.backticked): TokenSyntax {
            return .\(raw: token.swiftKind)Token()
          }
          """
        )
      }
    }
    VariableDecl("""
      /// The `eof` token
      static var eof: TokenSyntax {
        return .eof()
      }
      """
    )

    VariableDecl("""
      /// The `open` contextual token
      static var open: TokenSyntax {
        return .contextualKeyword("open").withTrailingTrivia(.space)
      }
      """
    )
  }
}
