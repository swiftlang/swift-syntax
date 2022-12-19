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

let tokenKindFile = SourceFile {
  EnumDecl("""
    /// Enumerates the kinds of tokens in the Swift language.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum TokenKind: Hashable
    """) {
    EnumCaseDecl("case eof")
    
    for token in SYNTAX_TOKENS {
      // Tokens that don't have a set text have an associated value that
      // contains their text.
      if token.text == nil {
        EnumCaseDecl("case \(raw: token.swiftKind)(String)")
      } else {
        EnumCaseDecl("case \(raw: token.swiftKind)")
      }
    }
    
    InitializerDecl("""
      /// Initializes a keyword token kind from its string representation. If the
      /// given string is not a keyword, this function returns `nil`.
      public init?(keyword: String)
      """) {
      SwitchStmt(expression: Expr("keyword")) {
        for token in SYNTAX_TOKENS where token.isKeyword {
          SwitchCase("case \"\(raw: token.text!)\":") {
            SequenceExpr("self = .\(raw: token.swiftKind)")
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return nil")
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("/// The textual representation of this token kind.") + .newlines(1),
      attributes: [AttributeListSyntax.Element.attribute(AttributeSyntax(attributeName: .identifier("_spi(Testing)\n")))],
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("text"),
      type: TypeAnnotation(type: TypeSyntax("String"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        for token in SYNTAX_TOKENS {
          
          if let text = token.text {
            SwitchCase("case .\(raw: token.swiftKind):") {
              ReturnStmt("return #\"\(raw: text)\"#")
            }
          } else {
            SwitchCase("case .\(raw: token.swiftKind)(let text):") {
              ReturnStmt("return text")
            }
          }
        }
        
        SwitchCase("case .eof:") {
          ReturnStmt(#"return """#)
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("""
        /// Returns `true` if the token is a Swift keyword.
        ///
        /// Keywords are reserved unconditionally for use by Swift and may not
        /// appear as identifiers in any position without being escaped. For example,
        /// `class`, `func`, or `import`.
        """) + .newlines(1),
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isKeyword"),
      type: TypeAnnotation(type: TypeSyntax("Bool"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCase("case .\(raw: token.swiftKind):") {
            ReturnStmt("return \(raw: token.isKeyword)")
          }
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("""
        /// Returns `true` if the token is a Swift punctuator.
        ///
        /// Punctuation tokens generally separate identifiers from each other. For
        /// example, the '<' and '>' characters in a generic parameter list, or the
        /// quote characters in a string literal.
        """) + .newlines(1),
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isPunctuation"),
      type: TypeAnnotation(type: TypeSyntax("Bool"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCase("case .\(raw: token.swiftKind):") {
            ReturnStmt("return \(raw: type(of: token) == PunctuatorSpec.self)")
          }
        }
      }
    }
    
    VariableDeclSyntax(
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("kind"),
      type: TypeAnnotation(type: TypeSyntax("String"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt(#"return "eof""#)
        }
        
        for token in SYNTAX_TOKENS {
          if token.text == nil {
            SwitchCase("case .\(raw: token.swiftKind)(_):") {
              ReturnStmt("return \"\(raw: token.kind)\"")
            }
          } else {
            SwitchCase("case .\(raw: token.swiftKind):") {
              ReturnStmt("return \"\(raw: token.kind)\"")
            }
          }
        }
      }
    }
    
    VariableDeclSyntax(
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("sourceLength"),
      type: TypeAnnotation(type: TypeSyntax("SourceLength"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return .zero")
        }
        
        for token in SYNTAX_TOKENS {
          if let text = token.text {
            SwitchCase("case .\(raw: token.swiftKind):") {
              ReturnStmt("return SourceLength(utf8Length: \(raw: text.count))")
            }
          } else {
            SwitchCase("case .\(raw: token.swiftKind)(let text):") {
              ReturnStmt("return SourceLength(of: text)")
            }
          }
        }
      }
    }
  }
  
  ExtensionDecl("extension TokenKind: Equatable") {
    FunctionDecl("public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool") {
      SwitchStmt(expression: Expr("(lhs, rhs)")) {
        SwitchCase("case (.eof, .eof):") {
          ReturnStmt("return true")
        }
        
        for token in SYNTAX_TOKENS {
          if token.text != nil {
            SwitchCase("case (.\(raw: token.swiftKind), .\(raw: token.swiftKind)):") {
              ReturnStmt("return true")
            }
          } else {
            SwitchCase("case (.\(raw: token.swiftKind)(let lhsText), .\(raw: token.swiftKind)(let rhsText)):") {
              ReturnStmt("return lhsText == rhsText")
            }
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }
  }
  
  EnumDecl("""
    /// Plain token kind value, without an associated `String` value.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum RawTokenKind: Equatable, Hashable
    """) {
    EnumCaseDecl("case eof")
    
    for token in SYNTAX_TOKENS {
      EnumCaseDecl("case \(raw: token.swiftKind)")
    }
    
    VariableDeclSyntax(
      attributes: [AttributeListSyntax.Element.attribute(AttributeSyntax(attributeName: .identifier("_spi(RawSyntax)\n")))],
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("defaultText"),
      type: TypeAnnotation(type: OptionalType("SyntaxText?"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt(#"return """#)
        }

        for token in SYNTAX_TOKENS {
          if let text = token.text {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmt("return #\"\(raw: text)\"#")
            }
          }
        }

        SwitchCaseSyntax("default:") {
          ReturnStmt("return nil")
        }
      }
    }

    VariableDeclSyntax(
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("nameForDiagnostics"),
      type: TypeAnnotation(type: TypeSyntax("String"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt(#"return "end of file""#)
        }

        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            ReturnStmt("return #\"\(raw: token.nameForDiagnostics)\"#")
          }
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("""
        /// Returns `true` if the token is a Swift keyword.
        ///
        /// Keywords are reserved unconditionally for use by Swift and may not
        /// appear as identifiers in any position without being escaped. For example,
        /// `class`, `func`, or `import`.
        """) + .newlines(1),
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isKeyword"),
      type: TypeAnnotation(type: TypeSyntax("Bool"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCase("case .\(raw: token.swiftKind):") {
            ReturnStmt("return \(raw: token.isKeyword)")
          }
        }
      }
    }
    
    VariableDeclSyntax(
      leadingTrivia: .docBlockComment("""
        /// Returns `true` if the token is a Swift punctuator.
        ///
        /// Punctuation tokens generally separate identifiers from each other. For
        /// example, the '<' and '>' characters in a generic parameter list, or the
        /// quote characters in a string literal.
        """) + .newlines(1),
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isPunctuation"),
      type: TypeAnnotation(type: TypeSyntax("Bool"))
    ) {
      SwitchStmt(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return false")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCase("case .\(raw: token.swiftKind):") {
            ReturnStmt("return \(raw: type(of: token) == PunctuatorSpec.self)")
          }
        }
      }
    }
    
    InitializerDecl("""
      @_spi(RawSyntax)
          public init?(keyword text: SyntaxText)
      """) {
      
      let tokensByLength = Dictionary(
        grouping: SYNTAX_TOKENS.filter { $0.isKeyword },
        by: { $0.text!.count }
      )
      
      SwitchStmt(expression: Expr("text.count")) {
        for len in tokensByLength.keys.sorted() {
          SwitchCase("case \(raw: len):") {
            SwitchStmt(expression: Expr("text")) {
              for token in tokensByLength[len]! {
                SwitchCase("case \"\(raw: token.text!)\":") {
                  SequenceExpr("self = .\(raw: token.swiftKind)")
                }
              }
              
              SwitchCase("default:") {
                ReturnStmt("return nil")
              }
            }
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return nil")
        }
      }
    }
  }
  
  ExtensionDecl("extension TokenKind") {
    FunctionDecl("""
      /// If the `rawKind` has a `defaultText`, `text` can be empty.
      @_spi(RawSyntax)
      public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind
      """) {
      SwitchStmt(expression: Expr("rawKind")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return .eof")
        }
        
        for token in SYNTAX_TOKENS {
          SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
            if token.text != nil {
              FunctionCallExpr("assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)")
              ReturnStmt("return .\(raw: token.swiftKind)")
            } else {
              ReturnStmt("return .\(raw: token.swiftKind)(text)")
            }
          }
        }
      }
    }

    FunctionDecl("""
      /// Returns the `RawTokenKind` of this `TokenKind` and, if this `TokenKind`
      /// has associated text, the associated text, otherwise `nil`.
      @_spi(RawSyntax)
      public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?)
      """) {
      SwitchStmt(expression: Expr("self")) {
        SwitchCaseSyntax("case .eof:") {
          ReturnStmt("return (.eof, nil)")
        }
        
        for token in SYNTAX_TOKENS {
          if token.text != nil {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmt("return (.\(raw: token.swiftKind), nil)")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: token.swiftKind)(let str):") {
              ReturnStmt("return (.\(raw: token.swiftKind), str)")
            }
          }
        }
      }
    }
  }
}
