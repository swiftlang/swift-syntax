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

let parserTokenSpecSetFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("@_spi(RawSyntax) import SwiftSyntax")

  for layoutNode in SYNTAX_NODES.compactMap(\.layoutNode) {
    for child in layoutNode.children {
      if case let .token(choices, _, _) = child.kind, choices.count > 1 {
        try! ExtensionDeclSyntax("extension \(raw: layoutNode.kind.syntaxType)") {
          try EnumDeclSyntax("enum \(raw: child.name)Options: TokenSpecSet") {
            for choice in choices {
              switch choice {
              case .keyword(let keywordText):
                let keyword = KEYWORDS.first(where: { $0.name == keywordText })!
                DeclSyntax("case \(raw: keyword.escapedName)")
              case .token(let tokenText):
                let token = SYNTAX_TOKEN_MAP[tokenText]!
                DeclSyntax("case \(token.varOrCaseName)")
              }
            }

            try InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
              try SwitchExprSyntax("switch PrepareForKeywordMatch(lexeme)") {
                for choice in choices {
                  switch choice {
                  case .keyword(let keywordText):
                    let keyword = KEYWORDS.first(where: { $0.name == keywordText })!
                    SwitchCaseSyntax("case TokenSpec(.\(raw: keyword.escapedName)): self = .\(raw: keyword.escapedName)")
                  case .token(let tokenText):
                    let token = SYNTAX_TOKEN_MAP[tokenText]!
                    SwitchCaseSyntax(
                      "case TokenSpec(.\(token.varOrCaseName)): self = .\(token.varOrCaseName)"
                    )
                  }
                }
                SwitchCaseSyntax("default: return nil")
              }
            }

            try VariableDeclSyntax("var spec: TokenSpec") {
              try SwitchExprSyntax("switch self") {
                for choice in choices {
                  switch choice {
                  case .keyword(let keywordText):
                    let keyword = KEYWORDS.first(where: { $0.name == keywordText })!
                    SwitchCaseSyntax(
                      "case .\(raw: keyword.escapedName): return .keyword(.\(raw: keyword.escapedName))"
                    )
                  case .token(let tokenText):
                    let token = SYNTAX_TOKEN_MAP[tokenText]!
                    SwitchCaseSyntax(
                      "case .\(token.varOrCaseName): return .\(token.varOrCaseName)"
                    )
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
