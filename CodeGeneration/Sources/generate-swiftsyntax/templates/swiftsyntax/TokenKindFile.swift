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
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum TokenKind: Hashable
    """
  ) {
    DeclSyntax("case eof")

    for token in SYNTAX_TOKENS {
      // Tokens that don't have a set text have an associated value that
      // contains their text.
      if let associatedValueClass = token.associatedValueClass {
        DeclSyntax("case \(raw: token.swiftKind)(\(raw: associatedValueClass))")
      } else if token.text == nil {
        DeclSyntax("case \(raw: token.swiftKind)(String)")
      } else {
        DeclSyntax("case \(raw: token.swiftKind)")
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
        for token in SYNTAX_TOKENS {
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              StmtSyntax("return String(syntaxText: assoc.defaultText)")
            }
          } else if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return #\"\(raw: text)\"#")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let text):") {
              StmtSyntax("return text")
            }
          }
        }

        SwitchCaseSyntax("case .eof:") {
          StmtSyntax(#"return """#)
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
        for token in SYNTAX_TOKENS {
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              StmtSyntax("return assoc.defaultText")
            }
          } else if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return #\"\(raw: text)\"#")
            }
          }
        }

        SwitchCaseSyntax("case .eof:") {
          StmtSyntax(#"return """#)
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
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return false")
        }

        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            StmtSyntax("return \(raw: type(of: token) == PunctuatorSpec.self)")
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension TokenKind: Equatable") {
    try FunctionDeclSyntax("public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool") {
      try SwitchExprSyntax("switch (lhs, rhs)") {
        SwitchCaseSyntax("case (.eof, .eof):") {
          StmtSyntax("return true")
        }

        for token in SYNTAX_TOKENS {
          if token.text != nil {
            SwitchCaseSyntax("case (.\(raw: token.swiftKind), .\(raw: token.swiftKind)):") {
              StmtSyntax("return true")
            }
          } else {
            SwitchCaseSyntax("case (.\(raw: token.swiftKind)(let lhsText), .\(raw: token.swiftKind)(let rhsText)):") {
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
    DeclSyntax("case eof")

    for token in SYNTAX_TOKENS {
      DeclSyntax("case \(raw: token.swiftKind)")
    }

    try VariableDeclSyntax(
      """
      @_spi(RawSyntax)
      public var defaultText: SyntaxText?
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax(#"return """#)
        }

        for token in SYNTAX_TOKENS {
          if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return #\"\(raw: text)\"#")
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
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return false")
        }

        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            StmtSyntax("return \(raw: type(of: token) == PunctuatorSpec.self)")
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
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return .eof")
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              DeclSyntax("var text = text")
              StmtSyntax(
                """
                return text.withSyntaxText { text in
                  return .keyword(Keyword(text)!)
                }
                """
              )
            }
          } else if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ExprSyntax("precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)")
              StmtSyntax("return .\(raw: token.swiftKind)")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return .\(raw: token.swiftKind)(text)")
            }
          }
        }
      }
    }

    try! FunctionDeclSyntax(
      """
      /// Returns the `RawTokenKind` of this `TokenKind` and, if this `TokenKind`
      /// has associated text, the associated text, otherwise `nil`.
      @_spi(RawSyntax)
      public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?)
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return (.eof, nil)")
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let keyword):") {
              StmtSyntax("return (.\(raw: token.swiftKind), String(syntaxText: keyword.defaultText))")
            }
          } else if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return (.\(raw: token.swiftKind), nil)")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let str):") {
              StmtSyntax("return (.\(raw: token.swiftKind), str)")
            }
          }
        }
      }
    }
  }
}
