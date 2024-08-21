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

let tokenKindFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! EnumDeclSyntax(
    """
    /// Enumerates the kinds of tokens in the Swift language.
    public enum TokenKind: Hashable, Sendable
    """
  ) {
    for tokenSpec in Token.allCases.map(\.spec) {
      // Tokens that don't have a set text have an associated value that
      // contains their text.
      if tokenSpec.kind == .keyword {
        DeclSyntax(
          """
          \(tokenSpec.apiAttributes)\
          case \(tokenSpec.enumCaseDeclName)(Keyword)
          """
        )
      } else if tokenSpec.text == nil {
        DeclSyntax(
          """
          \(tokenSpec.apiAttributes)\
          case \(tokenSpec.enumCaseDeclName)(String)
          """
        )
      } else {
        DeclSyntax(
          """
          \(tokenSpec.apiAttributes)\
          case \(tokenSpec.enumCaseDeclName)
          """
        )
      }
    }

    try VariableDeclSyntax(
      """
      /// The textual representation of this token kind.
      @_spi(Testing)
      public var text: String
      """
    ) {
      try SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if tokenSpec.kind == .keyword {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName)(let assoc):") {
              StmtSyntax("return String(syntaxText: assoc.defaultText)")
            }
          } else if let text = tokenSpec.text {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              StmtSyntax("return \(literal: text)")
            }
          } else {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName)(let text):") {
              StmtSyntax("return text")
            }
          }
        }
      }
    }

    try VariableDeclSyntax(
      """
      /// If this token kind always has the same syntax text, that syntax text, otherwise `nil`.
      @_spi(RawSyntax)
      public var defaultText: SyntaxText?
      """
    ) {
      try SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if tokenSpec.kind == .keyword {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName)(let assoc):") {
              StmtSyntax("return assoc.defaultText")
            }
          } else if let text = tokenSpec.text {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              StmtSyntax("return \(literal: text)")
            }
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax(#"return """#)
        }
      }
    }

    try VariableDeclSyntax(
      """
      /// Returns `true` if the token is a Swift punctuator.
      ///
      /// Punctuation tokens generally separate identifiers from each other. For
      /// example, the '<' and '>' characters in a generic parameter list, or the
      /// quote characters in a string literal.
      public var isPunctuation: Bool
      """
    ) {
      try SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
            StmtSyntax("return \(raw: tokenSpec.kind == .punctuation)")
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension TokenKind: Equatable") {
    try FunctionDeclSyntax("public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool") {
      try SwitchExprSyntax("switch (lhs, rhs)") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if tokenSpec.text != nil {
            SwitchCaseSyntax("case (.\(tokenSpec.enumCaseCallName), .\(tokenSpec.enumCaseCallName)):") {
              StmtSyntax("return true")
            }
          } else {
            SwitchCaseSyntax(
              "case (.\(tokenSpec.enumCaseCallName)(let lhsText), .\(tokenSpec.enumCaseCallName)(let rhsText)):"
            ) {
              StmtSyntax("return lhsText == rhsText")
            }
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }
  }

  try! EnumDeclSyntax(
    """
    // Note: It's important that this enum is marked as having a raw base kind
    // because it significantly improves performance when comparing two
    // `RawTokenBaseKind` for equality. With the raw value, it compiles down to
    // a primitive integer compare, without, it calls into `__derived_enum_equals`.
    @frozen // FIXME: Not actually stable, works around a miscompile
    @_spi(RawSyntax)
    public enum RawTokenKind: UInt8, Equatable, Hashable
    """
  ) {
    for tokenSpec in Token.allCases.map(\.spec) {
      DeclSyntax(
        """
        \(tokenSpec.apiAttributes)\
        case \(tokenSpec.enumCaseDeclName)
        """
      )
    }

    try VariableDeclSyntax(
      """
      @_spi(RawSyntax)
      public var defaultText: SyntaxText?
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if let text = tokenSpec.text {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              StmtSyntax("return \(literal: text)")
            }
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return nil")
        }
      }
    }

    try! VariableDeclSyntax(
      """
      /// Returns `true` if the token is a Swift punctuator.
      ///
      /// Punctuation tokens generally separate identifiers from each other. For
      /// example, the '<' and '>' characters in a generic parameter list, or the
      /// quote characters in a string literal.
      public var isPunctuation: Bool
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
            StmtSyntax("return \(raw: tokenSpec.kind == .punctuation)")
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension TokenKind") {
    try! FunctionDeclSyntax(
      """
      /// If the `rawKind` has a `defaultText`, `text` can be empty.
      @_spi(RawSyntax)
      public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind
      """
    ) {
      try! SwitchExprSyntax("switch rawKind") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if tokenSpec.kind == .keyword {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              DeclSyntax("var text = text")
              StmtSyntax(
                """
                return text.withSyntaxText { text in
                  return .keyword(Keyword(text)!)
                }
                """
              )
            }
          } else if tokenSpec.text != nil {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              ExprSyntax("precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)")
              StmtSyntax("return .\(tokenSpec.memberCallName)")
            }
          } else {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              StmtSyntax("return .\(tokenSpec.memberCallName)(text)")
            }
          }
        }
      }
    }

    try! FunctionDeclSyntax(
      """
      /// Returns the ``RawTokenKind`` of this ``TokenKind`` and, if this ``TokenKind``
      /// has associated text, the associated text, otherwise `nil`.
      @_spi(RawSyntax)
      public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?)
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        for tokenSpec in Token.allCases.map(\.spec) {
          if tokenSpec.kind == .keyword {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName)(let keyword):") {
              StmtSyntax("return (.\(tokenSpec.memberCallName), String(syntaxText: keyword.defaultText))")
            }
          } else if tokenSpec.text != nil {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName):") {
              StmtSyntax("return (.\(tokenSpec.memberCallName), nil)")
            }
          } else {
            SwitchCaseSyntax("case .\(tokenSpec.enumCaseCallName)(let str):") {
              StmtSyntax("return (.\(tokenSpec.memberCallName), str)")
            }
          }
        }
      }
    }
  }
}
