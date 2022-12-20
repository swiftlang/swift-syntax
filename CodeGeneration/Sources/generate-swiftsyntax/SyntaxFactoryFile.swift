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

/// Generates a Swift call to make the raw syntax for a given Child object.
fileprivate func makeMissingSwiftChild(_ child: Child) -> String {
  if child.isToken {
    let token = child.mainToken
    let tokenKind = token?.swiftKind ?? token?.text ?? #"("")"#
    //                                      if not token or not token.text:
    //                                        tok_kind += '("")'
    return "RawSyntax.makeMissingToken(kind: TokenKind.\(tokenKind), arena: arena)"
  } else {
    let missingKind: String
    
    if child.syntaxKind == "Syntax" {
      missingKind = "missing"
    } else if SYNTAX_BASE_KINDS.contains(child.syntaxKind) {
      missingKind = "missing\(child.syntaxKind)"
    } else {
      missingKind = child.swiftSyntaxKind
    }
    
    return "RawSyntax.makeEmptyLayout(kind: SyntaxKind.\(missingKind), arena: arena)"
  }
}

let syntaxFactoryFile = SourceFile(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDecl("""
    //===----------------------------------------------------------------------===//
    //
    // This file defines the SyntaxFactory, one of the most important client-facing
    // types in lib/Syntax and likely to be very commonly used.
    //
    // Effectively a namespace, SyntaxFactory is never instantiated, but is *the*
    // one-stop shop for making new Syntax nodes. Putting all of these into a
    // collection of static methods provides a single point of API lookup for
    // clients' convenience.
    //
    //===----------------------------------------------------------------------===//
    
    public enum SyntaxFactory
    """) {
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on TokenSyntax")
      public static func makeToken(_ kind: TokenKind, presence: SourcePresence,
                                   leadingTrivia: Trivia = [],
                                   trailingTrivia: Trivia = []) -> TokenSyntax {
        TokenSyntax(
          kind,
          leadingTrivia: leadingTrivia,
          trailingTrivia: trailingTrivia,
          presence: presence)
      }
      
      /// MARK: Syntax Node Creation APIs
      """)
    
    for node in SYNTAX_NODES {
      if node.isBase {
        // Pass
      } else if !node.children.isEmpty {
        let childParams = node.children
          .map { child in
            var paramType = child.typeName
            if child.isOptional {
              paramType += "?"
            }
            
            if child.isUnexpectedNodes {
              // It would be nice if we could label all of these arguments 'unexpected'.
              // But if we do this, we hit https://github.com/apple/swift/issues/60274.
              return "_ \(child.swiftName): \(paramType) = nil"
            } else {
              return "\(child.swiftName): \(paramType)"
            }
          }
          .joined(separator: ", ")
        
        FunctionDecl("""
          @available(*, deprecated, message: "Use initializer on \(node.name)")
          public static func make\(node.syntaxKind)(\(childParams)) -> \(node.name)
          """) {
          VariableDecl(letOrVarKeyword: .let) {
            PatternBinding(
              pattern: IdentifierPattern(identifier: .identifier("layout")),
              typeAnnotation: TypeAnnotation(type: ArrayType("[RawSyntax?]")),
              initializer: InitializerClauseSyntax(
                value: ArrayExpr {
                  for child in node.children {
                    if child.isOptional {
                      ArrayElement(
                        expression: Expr("\(raw: child.swiftName)?.raw")
                      )
                    } else {
                      ArrayElement(
                        expression: Expr("\(raw: child.swiftName).raw")
                      )
                    }
                  }
                }
              )
            )
          }
          
          ReturnStmt("""
            return withExtendedLifetime(SyntaxArena()) { arena in
              let raw = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: node.swiftSyntaxKind),
                                             from: layout, arena: arena)
              let data = SyntaxData.forRoot(raw)
              return \(raw: node.name)(data)
            }
          """)
        }
      } else if node.isSyntaxCollection {
        FunctionDecl("""
          @available(*, deprecated, message: "Use initializer on \(raw: node.name)")
          public static func make\(raw: node.syntaxKind)(
            _ elements: [ \(raw: node.collectionElementType.syntaxBaseName)]) -> \(raw: node.name) {
              return withExtendedLifetime(SyntaxArena()) { arena in
                let raw = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: node.swiftSyntaxKind),
                                               from: elements.map { $0.raw }, arena: arena)
                let data = SyntaxData.forRoot(raw)
                return \(raw: node.name)(data)
              }
          }
          """)
      }
      
      if !node.isBase {
        let defaultPresence = node.isMissing ? "missing" : "present"
        FunctionDecl("""
            @available(*, deprecated, message: "Use initializer on \(node.name)")
            public static func makeBlank\(node.syntaxKind)(presence: SourcePresence = .\(defaultPresence)) -> \(node.name)
            """) {
          ReturnStmt(
            expression: FunctionCallExprSyntax(
              callee: Expr("withExtendedLifetime"),
              trailingClosure: ClosureExpr(
                signature: ClosureSignature(
                  input: .simpleInput(ClosureParamList {
                    ClosureParamSyntax(name: .identifier("arena"))
                  }),
                  inTok: .inKeyword(leadingTrivia: .space) // TODO: Remove when PR-1161 is merged.
                ),
                statementsBuilder: {
                  VariableDecl(
                    letOrVarKeyword: .let) {
                      PatternBinding(
                        pattern: IdentifierPattern(identifier: .identifier("data")),
                        initializer: InitializerClause(
                          value: FunctionCallExprSyntax(
                            calledExpression: MemberAccessExpr("SyntaxData.forRoot"),
                            leftParen: .leftParen,
                            rightParen: .rightParen,
                            argumentListBuilder: {
                              TupleExprElement(
                                expression: FunctionCallExpr(
                                  callee: MemberAccessExpr("RawSyntax.makeLayout")) {
                                    TupleExprElement(
                                      label: .identifier("kind"),
                                      colon: .colon,
                                      expression: Expr(".\(raw: node.swiftSyntaxKind)")
                                    )
                                    
                                    TupleExprElement(
                                      label: .identifier("from"),
                                      colon: .colon,
                                      expression: ArrayExpr {
                                        for child in node.children {
                                          if child.isToken {
                                            ArrayElement(
                                              expression: NilLiteralExpr(),
                                              trailingTrivia: .newline
                                            )
                                          } else {
                                            ArrayElement(
                                              expression: Expr("\(raw: makeMissingSwiftChild(child))"),
                                              trailingTrivia: .newline
                                            )
                                          }
                                        }
                                      }
                                    )
                                    
                                    TupleExprElement(
                                      label: "arena",
                                      expression: "arena"
                                    )
                                  }
                              )
                            }
                          )
                        )
                      )
                    }
                  //            let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .\(node.swiftSyntaxKind),
                  //                                                               from: [
                  //                                                                %     for child in node.children:
                  //                                                                            %       if child.is_optional:
                  //                                                                            nil,
                  //                                                                          %       else:
                  //                                                                            ${make_missing_swift_child(child)},
                  //                                                                          %       end
                  //                                                                          %     end
                  //                                                               ], arena: arena))
                  
                  ReturnStmt("return \(raw: node.name)(data)")
                }
              ),
              argumentList: {
                TupleExprElement(
                  expression: FunctionCallExpr(callee: Expr("SyntaxArena"))
                )
              }
            )
          )
        }
      }
    }
    
    /// MARK: Token Creation APIs
    
    for token in SYNTAX_TOKENS {
      let leadingTrivia = token.requiresLeadingSpace ? ".space" : "[]"
      let trailingTrivia = token.requiresLeadingSpace ? ".space" : "[]"
      
      if token.isKeyword {
        FunctionDecl("""
          @available(*, deprecated, message: "Use TokenSyntax.\(raw: token.swiftKind)Keyword instead")
          public static func make\(raw: token.name)Keyword(
            leadingTrivia: Trivia = \(raw: leadingTrivia),
            trailingTrivia: Trivia = \(raw: trailingTrivia)
          ) -> TokenSyntax {
            return makeToken(.\(raw: token.swiftKind), presence: .present,
                             leadingTrivia: leadingTrivia,
                             trailingTrivia: trailingTrivia)
          }
          """)
      } else if token.text != nil {
        FunctionDecl("""
          @available(*, deprecated, message: "Use TokenSyntax.\(raw: token.swiftKind)Token instead")
          public static func make\(raw: token.name)Token(
            leadingTrivia: Trivia = \(raw: leadingTrivia),
            trailingTrivia: Trivia = \(raw: trailingTrivia)
          ) -> TokenSyntax {
            return makeToken(.\(raw: token.swiftKind), presence: .present,
                             leadingTrivia: leadingTrivia,
                             trailingTrivia: trailingTrivia)
          }
          """)
        
      } else {
        FunctionDecl("""
          @available(*, deprecated, message: "Use TokenSyntax.\(raw: token.swiftKind) instead")
          public static func make\(raw: token.name)(
            _ text: String,
            leadingTrivia: Trivia = \(raw: leadingTrivia),
            trailingTrivia: Trivia = \(raw: trailingTrivia)
          ) -> TokenSyntax {
            return makeToken(.\(raw: token.swiftKind)(text), presence: .present,
                             leadingTrivia: leadingTrivia,
                             trailingTrivia: trailingTrivia)
          }
          """)
        
      }
    }
    
    /// MARK: Convenience APIs
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
      public static func makeVoidTupleType() -> TupleTypeSyntax {
        return makeTupleType(leftParen: makeLeftParenToken(),
                             elements: makeBlankTupleTypeElementList(),
                             rightParen: makeRightParenToken())
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
      public static func makeTupleTypeElement(name: TokenSyntax?,
        colon: TokenSyntax?, type: TypeSyntax,
        trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
        return makeTupleTypeElement(inOut: nil, name: name, secondName: nil,
                                    colon: colon, type: type, ellipsis: nil,
                                    initializer: nil, trailingComma: trailingComma)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
      public static func makeTupleTypeElement(type: TypeSyntax,
        trailingComma: TokenSyntax?) -> TupleTypeElementSyntax  {
        return makeTupleTypeElement(name: nil, colon: nil,
                                    type: type, trailingComma: trailingComma)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
      public static func makeGenericParameter(name: TokenSyntax,
          trailingComma: TokenSyntax) -> GenericParameterSyntax {
        return makeGenericParameter(attributes: nil, name: name, ellipsis: nil,
                                    colon: nil, inheritedType: nil,
                                    trailingComma: trailingComma)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
      public static func makeTypeIdentifier(_ name: String,
        leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TypeSyntax {
        let identifier = makeIdentifier(name, leadingTrivia: leadingTrivia,
                                        trailingTrivia: trailingTrivia)
        let typeIdentifier = makeSimpleTypeIdentifier(name: identifier,
                                                      genericArgumentClause: nil)
        return TypeSyntax(typeIdentifier)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
      public static func makeAnyTypeIdentifier(leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TypeSyntax {
        return makeTypeIdentifier("Any", leadingTrivia: leadingTrivia,
                                  trailingTrivia: trailingTrivia)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
      public static func makeSelfTypeIdentifier(leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TypeSyntax {
        return makeTypeIdentifier("Self", leadingTrivia: leadingTrivia,
                                  trailingTrivia: trailingTrivia)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
      public static func makeTypeToken(leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TokenSyntax {
        return makeIdentifier("Type", leadingTrivia: leadingTrivia,
                              trailingTrivia: trailingTrivia)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use TokenSyntax.protocol")
      public static func makeProtocolToken(leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TokenSyntax {
        return makeIdentifier("Protocol", leadingTrivia: leadingTrivia,
                              trailingTrivia: trailingTrivia)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use TokenSyntax.spacedBinaryOperator")
      public static func makeBinaryOperator(_ name: String,
        leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> TokenSyntax {
        return makeToken(.spacedBinaryOperator(name),
                         presence: .present,
                         leadingTrivia: leadingTrivia,
                         trailingTrivia: trailingTrivia)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
      public static func makeStringLiteralExpr(_ text: String,
        leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> StringLiteralExprSyntax {
        let string = makeStringSegment(text)
        let segment = makeStringSegment(content: string)
        let segments = makeStringLiteralSegments([Syntax(segment)])
        let openQuote = makeStringQuoteToken(leadingTrivia: leadingTrivia)
        let closeQuote = makeStringQuoteToken(trailingTrivia: trailingTrivia)
        return makeStringLiteralExpr(openDelimiter: nil,
                                     openQuote: openQuote,
                                     segments: segments,
                                     closeQuote: closeQuote,
                                     closeDelimiter: nil)
      }
      """)
    
    FunctionDecl("""
      @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
      public static func makeVariableExpr(_ text: String,
        leadingTrivia: Trivia = [],
        trailingTrivia: Trivia = []) -> IdentifierExprSyntax {
        let string = makeIdentifier(text,
          leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
        return makeIdentifierExpr(identifier: string,
                                  declNameArguments: nil)
      }
      """)
    
  }
}
