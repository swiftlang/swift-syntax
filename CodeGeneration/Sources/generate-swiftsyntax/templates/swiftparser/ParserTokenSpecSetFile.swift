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
  DeclSyntax("@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax")

  for layoutNode in SYNTAX_NODES.compactMap(\.layoutNode) {
    for child in layoutNode.children {
      if case let .token(choices, _, _) = child.kind, choices.count > 1 {
        try! ExtensionDeclSyntax("extension \(layoutNode.kind.syntaxType)") {
          try EnumDeclSyntax(
            """
            @_spi(Diagnostics)
            public enum \(child.tokenSpecSetType): TokenSpecSet
            """
          ) {
            for choice in choices {
              switch choice {
              case .keyword(let keyword):
                DeclSyntax(
                  """
                  \(keyword.spec.apiAttributes)\
                  case \(keyword.spec.varOrCaseName.backtickedIfNeeded)
                  """
                )
              case .token(let token):
                DeclSyntax("case \(token.spec.varOrCaseName)")
              }
            }

            try InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
              try SwitchExprSyntax("switch PrepareForKeywordMatch(lexeme)") {
                for choice in choices {
                  switch choice {
                  case .keyword(let keyword):
                    let caseName = keyword.spec.varOrCaseName
                    SwitchCaseSyntax("case TokenSpec(.\(caseName)): self = .\(caseName)")
                  case .token(let token):
                    let caseName = token.spec.varOrCaseName
                    SwitchCaseSyntax("case TokenSpec(.\(caseName)): self = .\(caseName)")
                  }
                }
                SwitchCaseSyntax("default: return nil")
              }
            }

            try VariableDeclSyntax("var spec: TokenSpec") {
              try SwitchExprSyntax("switch self") {
                for choice in choices {
                  switch choice {
                  case .keyword(let keyword):
                    let caseName = keyword.spec.varOrCaseName
                    SwitchCaseSyntax("case .\(caseName): return .keyword(.\(caseName))")
                  case .token(let token):
                    let caseName = token.spec.varOrCaseName
                    SwitchCaseSyntax("case .\(caseName): return .\(caseName)")
                  }
                }
              }
            }

            try VariableDeclSyntax(
              """
              /// Returns a token that satisfies the `TokenSpec` of this case.
              ///
              /// If the token kind of this spec has variable text, e.g. for an identifier, this returns a token with empty text.
              @_spi(Diagnostics)
              public var tokenSyntax: TokenSyntax
              """
            ) {
              try SwitchExprSyntax("switch self") {
                for choice in choices {
                  switch choice {
                  case .keyword(let keyword):
                    let caseName = keyword.spec.varOrCaseName
                    SwitchCaseSyntax("case .\(caseName): return .keyword(.\(caseName))")
                  case .token(let token):
                    let caseName = token.spec.varOrCaseName
                    if token.spec.text != nil {
                      SwitchCaseSyntax("case .\(caseName): return .\(caseName)Token()")
                    } else {
                      SwitchCaseSyntax(#"case .\#(caseName): return .\#(caseName)("")"#)
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
}
