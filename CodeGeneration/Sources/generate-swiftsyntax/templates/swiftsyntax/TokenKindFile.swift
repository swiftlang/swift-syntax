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
    
    InitializerDeclSyntax("""
      /// Initializes a keyword token kind from its string representation. If the
      /// given string is not a keyword, this function returns `nil`.
      public init?(keyword: String)
      """) {
      SwitchStmtSyntax(expression: ExprSyntax("keyword")) {
        for token in SYNTAX_TOKENS where token.isKeyword {
          SwitchCaseSyntax("case \"\(raw: token.text!)\":") {
            SequenceExprSyntax("self = .\(raw: token.swiftKind)")
          }
        }
        
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return nil")
        }
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
    /// Plain token kind value, without an associated `String` value.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum RawTokenKind: Equatable, Hashable
    """) {
    EnumCaseDeclSyntax("case eof")
    
    for token in SYNTAX_TOKENS {
      if let associatedValueClass = token.associatedValueClass {
        EnumCaseDeclSyntax("case \(raw: token.swiftKind)(\(raw: associatedValueClass))")
      } else {
        EnumCaseDeclSyntax("case \(raw: token.swiftKind)")
      }
    }
    
    VariableDeclSyntax(
      attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("_spi"), leftParen: .leftParenToken(), argument: .token(.identifier("RawSyntax")), rightParen: .rightParenToken()))],
      modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public))],
      name: IdentifierPatternSyntax("defaultText"),
      type: TypeAnnotationSyntax(type: OptionalTypeSyntax("SyntaxText?"))
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return """#)
        }

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
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax(#"return "end of file""#)
        }

        for token in SYNTAX_TOKENS where token.swiftKind != "keyword" {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmtSyntax("return #\"\(raw: token.nameForDiagnostics)\"#")
          }
        }
        SwitchCaseSyntax("case .keyword(let keyword):") {
          ReturnStmtSyntax("return String(syntaxText: keyword.defaultText)")
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
    
    InitializerDeclSyntax("""
      @_spi(RawSyntax)
      public init?(keyword text: SyntaxText)
      """) {
      
      let tokensByLength = Dictionary(
        grouping: SYNTAX_TOKENS.filter { $0.isKeyword },
        by: { $0.text!.count }
      )
      
      SwitchStmtSyntax(expression: ExprSyntax("text.count")) {
        for len in tokensByLength.keys.sorted() {
          SwitchCaseSyntax("case \(raw: len):") {
            SwitchStmtSyntax(expression: ExprSyntax("text")) {
              for token in tokensByLength[len]! {
                SwitchCaseSyntax("case \"\(raw: token.text!)\":") {
                  SequenceExprSyntax("self = .\(raw: token.swiftKind)")
                }
              }
              
              SwitchCaseSyntax("default:") {
                ReturnStmtSyntax("return nil")
              }
            }
          }
        }
        
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return nil")
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
      SwitchStmtSyntax(expression: ExprSyntax("rawKind")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmtSyntax("return .eof")
        }

        for token in SYNTAX_TOKENS {
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              FunctionCallExprSyntax("assert(text.isEmpty || String(syntaxText: assoc.defaultText) == text)")
              ReturnStmtSyntax("return .\(raw: token.swiftKind)(assoc)")
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
          if token.associatedValueClass != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let assoc):") {
              ReturnStmtSyntax("return (.\(raw: token.swiftKind)(assoc), nil)")
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
