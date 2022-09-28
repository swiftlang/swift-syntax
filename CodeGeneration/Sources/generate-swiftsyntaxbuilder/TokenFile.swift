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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let tokenFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )
  ImportDecl(
    path: "SwiftBasicFormat"
  )

  let tokenType = SyntaxBuildableType(syntaxKind: "Token")
  let conformances = ["SyntaxBuildable"] + tokenType.convertibleToTypes.map(\.expressibleAsBaseName)
  + tokenType.elementInCollections.map(\.expressibleAsBaseName)


  StructDecl(
    leadingTrivia: .newline +
      .docLineComment("""
      /// Represents `TokenSyntax` in `SwiftSyntaxBuilder`.
      /// At the moment, this just wraps `TokenSyntax`, but we can make it store just the information necessary to build a `TokenSyntax` in the future.
      """) +
      .newline,
    modifiers: [Token.public],
    identifier: "Token",
    inheritanceClause: createTypeInheritanceClause(conformances: conformances)
  ) {
    VariableDecl("let tokenSyntax: TokenSyntax")
    VariableDecl("let leadingTrivia: \(OptionalType(wrappedType: "Trivia"))")
    VariableDecl("let trailingTrivia: \(OptionalType(wrappedType: "Trivia"))")
    VariableDecl("var text: String { tokenSyntax.text }")

    InitializerDecl(
      """

      public init(
        tokenSyntax: TokenSyntax,
        leadingTrivia: \(OptionalType(wrappedType: "Trivia")) = nil,
        trailingTrivia: \(OptionalType(wrappedType: "Trivia")) = nil
      ) {
        self.tokenSyntax = tokenSyntax
        self.leadingTrivia = leadingTrivia
        self.trailingTrivia = trailingTrivia
      }
      """
    )

    for leadingTrailing in ["Leading", "Trailing"] {
      FunctionDecl(
        """

        public func with\(leadingTrailing)Trivia(_ \(lowercaseFirstWord(name: leadingTrailing))Trivia: Trivia) -> Token {
          Token(
            tokenSyntax: tokenSyntax,
            leadingTrivia: leadingTrivia,
            trailingTrivia: trailingTrivia
          )
        }
        """
      )
    }

    FunctionDecl(
      """

      public func buildToken(format: Format) -> TokenSyntax {
        var result = format.format(syntax: tokenSyntax)
        if let leadingTrivia = leadingTrivia {
          result = result.withLeadingTrivia(leadingTrivia)
        }
        if let trailingTrivia = trailingTrivia {
          result = result.withTrailingTrivia(trailingTrivia)
        }
        return result
      }
      """
    )

    FunctionDecl(
      """

      public func buildSyntax(format: Format) -> Syntax {
        Syntax(self.buildToken(format: format))
      }
      """
    )

    for conformance in tokenType.elementInCollections {
      FunctionDecl(
        """

        /// Conformance to \(conformance.expressibleAsBaseName)
        public func create\(conformance.buildableBaseName)() -> \(conformance.buildableBaseName) {
          return \(conformance.buildableBaseName)([self])
        }
        """
      )
    }

    for conformance in tokenType.convertibleToTypes {
      let param = Node.from(type: conformance).singleNonDefaultedChild
      FunctionDecl(
        """

        /// Conformance to \(conformance.expressibleAsBaseName)
        public func create\(conformance.buildableBaseName)() -> \(conformance.buildableBaseName) {
          return \(conformance.buildableBaseName)(\(param.swiftName): self)
        }
        """
      )
    }

    for buildable in ["SyntaxBuildable", "ExprBuildable"] {
      FunctionDecl(
        """

        /// `Token` conforms to `\(buildable)` via different paths, so we need to pick one default conversion path.
        public func create\(buildable)() -> \(buildable) {
          return createIdentifierExpr()
        }
        """
      )
    }
  }

  ExtensionDecl(
    leadingTrivia: .newline + .docLineComment("/// Namespace for commonly used tokens with default trivia.") + .newline,
    modifiers: [Token.public],
    extendedType: "Token"
  ) {
    for token in SYNTAX_TOKENS {
      if token.isKeyword {
        VariableDecl(
          """

          /// The `\(token.text!)` keyword
          static var \(token.name.withFirstCharacterLowercased.backticked): Token {
            Token(tokenSyntax: TokenSyntax.\(token.swiftKind)())
          }
          """
        )
      } else if let text = token.text {
        VariableDecl(
          """

          /// The `\(text)` token
          static var \(token.name.withFirstCharacterLowercased.backticked): Token {
            Token(tokenSyntax: TokenSyntax.\(token.swiftKind)Token())
          }
          """
        )
      } else {
        FunctionDecl(
          """
          static func \(token.name.withFirstCharacterLowercased.backticked)(_ text: String) -> Token {
            Token(tokenSyntax: TokenSyntax.\(token.swiftKind)(text))
          }
          """
        )
      }
    }
    VariableDecl(
      """

      /// The `eof` token
      static var eof: Token {
        Token(tokenSyntax: TokenSyntax.eof())
      }
      """
    )
    VariableDecl(
      """

      /// The `open` contextual token
      static var open: Token {
        Token(tokenSyntax: TokenSyntax.contextualKeyword("open").withTrailingTrivia(.space))
      }
      """
    )
  }
}
