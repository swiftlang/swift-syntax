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

let tokenKindFile = SourceFileSyntax {
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

    try! VariableDeclSyntax("public var nameForDiagnostics: String") {
      try! SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax(#"return "end of file""#)
        }

        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            StmtSyntax("return #\"\(raw: token.nameForDiagnostics)\"#")
          }
        }
        SwitchCaseSyntax("case .keyword(let keyword):") {
          StmtSyntax("return String(syntaxText: keyword.defaultText)")
        }
      }
    }

    try VariableDeclSyntax(
      """
      /// Returns `true` if the token is a Swift keyword.
      ///
      /// Keywords are reserved unconditionally for use by Swift and may not
      /// appear as identifiers in any position without being escaped. For example,
      /// `class`, `func`, or `import`.
      public var isLexerClassifiedKeyword: Bool
      """
    ) {
      try SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return false")
        }

        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            StmtSyntax("return \(raw: token.isKeyword)")
          }
        }

        SwitchCaseSyntax("case .keyword(let keyword):") {
          StmtSyntax("return keyword.isLexerClassified")
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
    public enum RawTokenBaseKind: UInt8, Equatable, Hashable
    """
  ) {
    DeclSyntax("case eof")

    for token in SYNTAX_TOKENS {
      DeclSyntax("case \(raw: token.swiftKind)")
    }
  }

  DeclSyntax(
    """
    fileprivate extension Keyword {
      static var rawValueZero: Keyword {
        return Keyword(rawValue: 0)!
      }
    }
    """
  )

  try! StructDeclSyntax(
    """
    /// Similar to `TokenKind` but without a `String` associated value.
    /// Technically, this should be an enum like
    /// ```
    /// enum RawTokenKind {
    ///   case eof
    ///   case associatedtypeKeyword
    ///   // remaining case from `RawTokenBaseKind`...
    ///   case keyword(Keyword)
    /// }
    /// ```
    ///
    /// But modelling it this way has significant performance implications since
    /// comparing two `RawTokenKind` calls into `__derived_enum_equals`. It's more
    /// effient to model the base kind as an enum with a raw value and store the
    /// keyword separately.
    ///
    /// Whenever `base` is not `keyword`, `keyword` should have a raw value
    /// of `0`.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public struct RawTokenKind: Equatable, Hashable
    """
  ) {
    DeclSyntax("public let base: RawTokenBaseKind")
    DeclSyntax("public let keyword: Keyword")

    DeclSyntax(
      """
      public init(base: RawTokenBaseKind, keyword: Keyword) {
        assert(base == .keyword || keyword.rawValue == 0)
        self.base = base
        self.keyword = keyword
      }
      """
    )

    DeclSyntax(
      """
      public static var eof: RawTokenKind {
        return RawTokenKind(base: .eof, keyword: .rawValueZero)
      }
      """
    )
    for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
      try VariableDeclSyntax("public static var \(raw: token.swiftKind): RawTokenKind") {
        StmtSyntax("return RawTokenKind(base: .\(raw: token.swiftKind), keyword: .rawValueZero)")
      }
    }

    DeclSyntax(
      """
      public static func keyword(_ keyword: Keyword) -> RawTokenKind {
        return RawTokenKind(base: .keyword, keyword: keyword)
      }
      """
    )

    try VariableDeclSyntax(
      """
      @_spi(RawSyntax)
      public var defaultText: SyntaxText?
      """
    ) {
      try! SwitchExprSyntax("switch self.base") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax(#"return """#)
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return self.keyword.defaultText")
            }
          } else if let text = token.text {
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
      try! SwitchExprSyntax("switch self.base") {
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
      try! SwitchExprSyntax("switch rawKind.base") {
        SwitchCaseSyntax("case .eof:") {
          StmtSyntax("return .eof")
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ExprSyntax("assert(text.isEmpty || String(syntaxText: rawKind.keyword.defaultText) == text)")
              StmtSyntax("return .keyword(rawKind.keyword)")
            }
          } else if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ExprSyntax("assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)")
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
              StmtSyntax("return (.\(raw: token.swiftKind)(keyword), nil)")
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
