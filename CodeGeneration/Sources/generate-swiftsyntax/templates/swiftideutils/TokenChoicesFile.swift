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

let tokenChoicesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  StmtSyntax("import SwiftSyntax")

  try! ExtensionDeclSyntax("public extension KeyPath where Root: SyntaxProtocol") {
    try! VariableDeclSyntax("var tokenChoices: [TokenKind]") {
      try! SwitchExprSyntax("switch self") {
        for node in SYNTAX_NODES {
          for child in node.children {
            if case .token(choices: let choices, requiresLeadingSpace: _, requiresTrailingSpace: _) = child.kind {
              SwitchCaseSyntax("case \\\(raw: node.name).\(raw: child.swiftName):") {
                let array = ArrayExprSyntax {
                  for choice in choices {
                    switch choice {
                    case .keyword(text: "init"):
                      ArrayElementSyntax(expression: ExprSyntax(".keyword(.`init`)"))
                    case .keyword(text: var text):
                      ArrayElementSyntax(expression: ExprSyntax(".keyword(.\(raw: text))"))
                    case .token(tokenKind: let kind):
                      let token = SYNTAX_TOKEN_MAP[kind]!
                      if token.text == nil {
                        ArrayElementSyntax(expression: ExprSyntax(#".\#(raw: token.swiftKind)("")"#))
                      } else {
                        ArrayElementSyntax(expression: ExprSyntax(".\(raw: token.swiftKind)"))
                      }
                    }
                  }
                }
                StmtSyntax("return \(array)")
              }
            }
          }
        }
        SwitchCaseSyntax("default: return []")
      }
    }
  }
}
