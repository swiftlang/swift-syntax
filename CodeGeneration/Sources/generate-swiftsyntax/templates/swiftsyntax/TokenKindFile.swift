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
  EnumDeclSyntax("""
    /// Enumerates the kinds of tokens in the Swift language.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum TokenKind: Hashable
    """) {
    EnumCaseDeclSyntax("case eof")
    
    for token in SYNTAX_TOKENS {
      // Tokens that don't have a set text have an associated value that
      // contains their text.
      if let associatedValueClass = token.associatedValueClass {
        EnumCaseDeclSyntax("case \(raw: token.swiftKind)(\(raw: associatedValueClass))")
      } else if token.text == nil {
        EnumCaseDeclSyntax("case \(raw: token.swiftKind)(String)")
      } else {
        EnumCaseDeclSyntax("case \(raw: token.swiftKind)")
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("/// The textual representation of this token kind.") + .newlines(1),
      attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("_spi"), leftParen: .leftParenToken(), argument: .token(.identifier("Testing")), rightParen: .rightParenToken()))],
      modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public))],
      name: IdentifierPatternSyntax("text"),
      type: TypeAnnotationSyntax(type: TypeSyntax("String"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for token in SYNTAX_TOKENS {
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              ReturnStmtSyntax("return String(syntaxText: assoc.defaultText)")
            }
          } else if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return #\"\(raw: text)\"#")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let text):") {
              ReturnStmtSyntax("return text")
            }
          }
        }
        
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return """#)
        }
      }
    }

    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("/// If this token kind always has the same syntax text, that syntax text, otherwise `nil`.") + .newlines(1),
      attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("_spi"), leftParen: .leftParenToken(), argument: .token(.identifier("RawSyntax")), rightParen: .rightParenToken()))],
      modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public))],
      name: IdentifierPatternSyntax("defaultText"),
      type: TypeAnnotationSyntax(type: TypeSyntax("SyntaxText?"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for token in SYNTAX_TOKENS {
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              ReturnStmtSyntax("return assoc.defaultText")
            }
          } else if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return #\"\(raw: text)\"#")
            }
          }
        }

        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return """#)
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax(#"return """#)
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia:[
        .docBlockComment("/// Returns `true` if the token is a Swift keyword."),
        .newlines(1),
        .docBlockComment("///"),
        .newlines(1),
        .docBlockComment("/// Keywords are reserved unconditionally for use by Swift and may not"),
        .newlines(1),
        .docBlockComment("/// appear as identifiers in any position without being escaped. For example,"),
        .newlines(1),
        .docBlockComment("/// `class`, `func`, or `import`."),
        .newlines(1)
      ],
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isLexerClassifiedKeyword"),
      type: TypeAnnotationSyntax(type: TypeSyntax("Bool"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return false")
        }
        
        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return \(raw: token.isKeyword)")
          }
        }
        SwitchCaseSyntax("case .keyword(let keyword):") {
          ReturnStmtSyntax("return keyword.isLexerClassified")
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: [
        .docBlockComment("/// Returns `true` if the token is a Swift punctuator."),
        .newlines(1),
        .docBlockComment("///"),
        .newlines(1),
        .docBlockComment("/// Punctuation tokens generally separate identifiers from each other. For"),
        .newlines(1),
        .docBlockComment("/// example, the '<' and '>' characters in a generic parameter list, or the"),
        .newlines(1),
        .docBlockComment("/// quote characters in a string literal."),
        .newlines(1)
      ],
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isPunctuation"),
      type: TypeAnnotationSyntax(type: TypeSyntax("Bool"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return \(raw: type(of: token) == PunctuatorSpec.self)")
          }
        }
      }
    }
  }
  
  ExtensionDeclSyntax("extension TokenKind: Equatable") {
    FunctionDeclSyntax("public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool") {
      SwitchStmtSyntax(expression: ExprSyntax("(lhs, rhs)")) {
        SwitchCaseSyntax("case (.eof, .eof):") {
          ReturnStmtSyntax("return true")
        }
        
        for token in SYNTAX_TOKENS {
          if token.text != nil {
            SwitchCaseSyntax("case (.\(raw: token.swiftKind), .\(raw: token.swiftKind)):") {
              ReturnStmtSyntax("return true")
            }
          } else {
            SwitchCaseSyntax("case (.\(raw: token.swiftKind)(let lhsText), .\(raw: token.swiftKind)(let rhsText)):") {
              ReturnStmtSyntax("return lhsText == rhsText")
            }
          }
        }
        
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }
  }
  
  EnumDeclSyntax("""
    // Note: It's important that this enum is marked as having a raw base kind
    // because it significantly improves performance when comparing two
    // `RawTokenBaseKind` for equality. With the raw value, it compiles down to
    // a primitive integer compare, without, it calls into `__derived_enum_equals`.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum RawTokenBaseKind: UInt8, Equatable, Hashable
    """) {
    EnumCaseDeclSyntax("case eof")
    
    for token in SYNTAX_TOKENS {
      EnumCaseDeclSyntax("case \(raw: token.swiftKind)")
    }
  }

  DeclSyntax("""
  fileprivate extension Keyword {
    static var rawValueZero: Keyword {
      return Keyword(rawValue: 0)!
    }
  }
  """)

  StructDeclSyntax("""
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
    """) {
    DeclSyntax("public let base: RawTokenBaseKind")
    DeclSyntax("public let keyword: Keyword")

    DeclSyntax("""
      public init(base: RawTokenBaseKind, keyword: Keyword) {
        assert(base == .keyword || keyword.rawValue == 0)
        self.base = base
        self.keyword = keyword
      }
      """
    )

    DeclSyntax("""
    public static var eof: RawTokenKind {
      return RawTokenKind(base: .eof, keyword: .rawValueZero)
    }
    """)
    for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
      VariableDeclSyntax(
        modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
        name: IdentifierPatternSyntax("\(raw: token.swiftKind)"),
        type: TypeAnnotationSyntax(type: TypeSyntax("RawTokenKind"))
      ) {
        StmtSyntax("return RawTokenKind(base: .\(raw: token.swiftKind), keyword: .rawValueZero)")
      }
    }

    DeclSyntax("""
    public static func keyword(_ keyword: Keyword) -> RawTokenKind {
      return RawTokenKind(base: .keyword, keyword: keyword)
    }
    """)
    
    VariableDeclSyntax(
      attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("_spi"), leftParen: .leftParenToken(), argument: .token(.identifier("RawSyntax")), rightParen: .rightParenToken()))],
      modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public))],
      name: IdentifierPatternSyntax("defaultText"),
      type: TypeAnnotationSyntax(type: OptionalTypeSyntax("SyntaxText?"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self.base")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return """#)
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return self.keyword.defaultText")
            }
          } else if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return #\"\(raw: text)\"#")
            }
          }
        }

        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return nil")
        }
      }
    }

    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("nameForDiagnostics"),
      type: TypeAnnotationSyntax(type: TypeSyntax("String"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self.base")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return "end of file""#)
        }

        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return #\"\(raw: token.nameForDiagnostics)\"#")
          }
        }
        SwitchCaseSyntax("case .keyword:") {
          ReturnStmtSyntax("return String(syntaxText: self.keyword.defaultText)")
        }
      }
    }

    VariableDeclSyntax(
      leadingTrivia: [
        .docBlockComment("/// Returns `true` if the token is a Swift keyword."),
        .newlines(1),
        .docBlockComment("///"),
        .newlines(1),
        .docBlockComment("/// Keywords are reserved unconditionally for use by Swift and may not"),
        .newlines(1),
        .docBlockComment("/// appear as identifiers in any position without being escaped. For example,"),
        .newlines(1),
        .docBlockComment("/// `class`, `func`, or `import`."),
        .newlines(1),
      ],
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isLexerClassifiedKeyword"),
      type: TypeAnnotationSyntax(type: TypeSyntax("Bool"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self.base")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return false")
        }
        
        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return \(raw: token.isKeyword)")
          }
        }
        SwitchCaseSyntax("case .keyword:") {
          ReturnStmtSyntax("return self.keyword.isLexerClassified")
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: [
        .docBlockComment("/// Returns `true` if the token is a Swift punctuator."),
        .newlines(1),
        .docBlockComment("///"),
        .newlines(1),
        .docBlockComment("/// Punctuation tokens generally separate identifiers from each other. For"),
        .newlines(1),
        .docBlockComment("/// example, the '<' and '>' characters in a generic parameter list, or the"),
        .newlines(1),
        .docBlockComment("/// quote characters in a string literal."),
            .newlines(1)
      ],
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isPunctuation"),
      type: TypeAnnotationSyntax(type: TypeSyntax("Bool"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self.base")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return \(raw: type(of: token) == PunctuatorSpec.self)")
          }
        }
      }
    }
  }
  
  ExtensionDeclSyntax("extension TokenKind") {
    FunctionDeclSyntax("""
      /// If the `rawKind` has a `defaultText`, `text` can be empty.
      @_spi(RawSyntax)
      public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind
      """) {
      SwitchStmtSyntax(expression: ExprSyntax("rawKind.base")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return .eof")
        }

        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              FunctionCallExprSyntax("assert(text.isEmpty || String(syntaxText: rawKind.keyword.defaultText) == text)")
              ReturnStmtSyntax("return .keyword(rawKind.keyword)")
            }
          } else if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              FunctionCallExprSyntax("assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)")
              ReturnStmtSyntax("return .\(raw: token.swiftKind)")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return .\(raw: token.swiftKind)(text)")
            }
          }
        }
      }
    }

    FunctionDeclSyntax("""
      /// Returns the `RawTokenKind` of this `TokenKind` and, if this `TokenKind`
      /// has associated text, the associated text, otherwise `nil`.
      @_spi(RawSyntax)
      public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?)
      """) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return (.eof, nil)")
        }
        
        for token in SYNTAX_TOKENS {
          if token.swiftKind == "keyword" {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let keyword):") {
              ReturnStmtSyntax("return (.\(raw: token.swiftKind)(keyword), nil)")
            }
          } else if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return (.\(raw: token.swiftKind), nil)")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let str):") {
              ReturnStmtSyntax("return (.\(raw: token.swiftKind), str)")
            }
          }
        }
      }
    }
  }
}
